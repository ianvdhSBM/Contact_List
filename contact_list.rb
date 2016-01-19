require_relative 'contact'
require 'pry'

# require_relative 'contacts.csv'
# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
 
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  
  # puts "\nWhat would you like to do?\n\n"

  # puts "new\t- Create a new contact"
  # puts "list\t- List all contacts"
  # puts "show\t- Show a contact"
  # puts "search\t- Search contacts"

  command = ARGV[0]

  case 
  when command == "new"
    puts "Contact name?"
    name = STDIN.gets.chomp

    puts "Contact email?"
    email = STDIN.gets.chomp

    Contact.create(name, email)

    puts "New contact created: #{name}, #{email}"

  when command == "update"
    puts "What is the new name?"
    new_name = STDIN.gets.chomp

    puts "What is the new email address?"
    new_email = STDIN.gets.chomp

    contact = Contact.update(ARGV[1], new_name, new_email)

    puts "Contact updated: #{contact.name}, #{contact.email}"

  when command == "destroy"
    Contact.destroy(ARGV[1])

    puts "Contact deleted"

  when command == "list"

    all_contacts = Contact.all

    all_contacts.each do |contact|
      puts "#{contact.id}. #{contact.name} (#{contact.email})"
    end 

    puts "---"
    puts "#{all_contacts.length} records found"

  when command == "show"
    contact = Contact.find(ARGV[1])

    puts "Contact name: \t#{contact.name}"
    puts "Contact e-mail: #{contact.email}"

  when command == "search"
    contact = Contact.search(ARGV[1].to_s)

    contact.each do |item|
      puts "#{item.id}. #{item.name} (#{item.email})"
    end 

  end

end
