require_relative 'contact'
require_relative 'setup'
require 'pry'
 
class ContactList

  # puts "\nWhat would you like to do?\n\n"

  # puts "new\t- Create a new contact"
  # puts "list\t- List all contacts"
  # puts "show\t- Show a contact"
  # puts "search\t- Search contacts"

  def new
    puts "Contact name?"
    name = STDIN.gets.chomp

    puts "Contact email?"
    email = STDIN.gets.chomp

    new_contact = Contact.create(name: name, email: email)

    if new_contact.errors.messages.empty?
      puts "New contact created: #{new_contact.name}, #{new_contact.email}"
    else
      new_contact.errors.messages.each do |k,v|
        puts "#{k}: #{v}"
        puts ""
      end
    end
    
  end

  def update(id)
    contact = Contact.find(id)

    puts "\nCONTACT: #{contact.name} is being updated"
    puts ""
    puts "What is the new name?"
    new_name = STDIN.gets.chomp

    puts "What is the new email address?"
    new_email = STDIN.gets.chomp

    contact.update(name: new_name, email: new_email)

    puts ""
    puts "Contact updated: #{contact.name}, #{contact.email}"
  end

  def destroy(id)
    contact = Contact.find(id)

    contact.destroy

    puts "#{contact.name} deleted"
  end

  def all
    all_contacts = Contact.all.order(:id)

    all_contacts.each do |contact|
      puts "#{contact.id}. #{contact.name} (#{contact.email})"
    end 

    puts "---"
    puts "#{all_contacts.length} records found"
  end

  def show(id)
    contact = Contact.find(id)

    puts "Contact name: \t#{contact.name}"
    puts "Contact e-mail: #{contact.email}"
  end

  def search(term)
    contact = Contact.where('name ILIKE ?', "%#{term}" )

    contact.each do |item|
      puts "#{item.id}. #{item.name} (#{item.email})"
    end
  end

end

contact_list = ContactList.new

command = ARGV[0]

  case 
  when command == "new"
    contact_list.new

  when command == "update"
    contact_list.update(ARGV[1])

  when command == "destroy"
    contact_list.destroy(ARGV[1])

  when command == "list"
    contact_list.all

  when command == "show"
    contact_list.show(ARGV[1])

  when command == "search"
    contact_list.search(ARGV[1])
    
  end