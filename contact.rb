require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
  end

  # def to_s
  #   "hello"
  # end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      all_contacts = []
      CSV.foreach('contacts.csv') do |row|
        all_contacts << Contact.new(row[0], row[1])

        # all_contacts << "#{$.}. #{row[0]}: (#{row[1]})"
        # puts all_contacts
        # puts "#{$.}. #{row[0]}: (#{row[1]})"
      end

      # all_contacts << "---"
      # all_contacts << "#{all_contacts.length - 1} records found"
      all_contacts
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      
      CSV.open('contacts.csv', 'a') do |csv|
          csv << [name, email]
      end

    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      all_contacts = []

      CSV.foreach('contacts.csv') do |row|
        all_contacts << Contact.new(row[0], row[1])
      end

      all_contacts[id - 1]

      # my_contact = all_contacts.Select do |contact|
      #   contact.include?(id)
      # end


      # CSV.shift()

    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      all_contacts = []

      CSV.foreach('contacts.csv') do |row|
        all_contacts << Contact.new(row[0], row[1])
      end

      found_contacts = all_contacts.select do |word|
        word = term
      end
      
      found_contacts
    end

  end

end



