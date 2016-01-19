require 'pry'
require 'pg'

# Represents a person in an address book.
class Contact

  attr_reader :id

  attr_accessor :name, :email

  def initialize(name, email, id=nil)
    @id = id
    @name = name
    @email = email
  end


  # Provides functionality for managing a list of Contacts in a database.
  class << self

    def connection
      @@connections ||= PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
      )
    end

    # Returns an Array of Contacts loaded from the database.
    def all
      contacts = []

      results = connection.exec('SELECT * FROM contacts ORDER BY id;')
      
      results.each do |row|
        contacts << Contact.new(
          row['name'],
          row['email'],
          row['id']
        )
      end

      contacts
    end

    def save(contact)
      if contact.id == nil
        result = Contact.connection.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2);", [contact.name, contact.email])
      else
        result = Contact.connection.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3;",[contact.name, contact.email, contact.id])
      end
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      new_contact = Contact.new(name, email)
      
      save(new_contact)
    end

    def update(id, new_name, new_email)

      contact = Contact.find(id)

      contact.name = new_name
      contact.email = new_email

      contact.save

      # save(contact)

      contact
    end

    def destroy(id)
      contact = Contact.find(id)

      result = Contact.connection.exec_params("DELETE FROM contacts WHERE id = $1;", [id])

    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      result = connection.exec_params("SELECT id, name, email FROM contacts WHERE id = $1;", [id])

      if row = result.first
         Contact.new(
          row['name'],
          row['email'],
          row['id']
        )
      else
        nil
      end

    end

    # Returns an array of contacts who match the given term.
    def search(term)
      contacts = []
          
      results = connection.exec_params("SELECT * FROM contacts WHERE name ILIKE ($1) OR email ILIKE ($1);", ["%#{term}%"])
      
      results.each do |row|
        contacts << Contact.new(
          row['name'],
          row['email'],
          row['id']
        )
      end

      contacts
    end

  end

end



