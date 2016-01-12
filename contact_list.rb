require_relative 'contact'
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
    Contact.create(name, email)

  when command == "list"
    all_contacts = Contact.all

    all_contacts.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name} (#{item.email})"
    end 

    puts "---"
    puts "#{all_contacts.length} records found"

  when command == "show"
    Contact.find(ARGV[1])

  when command == "search"
    Contact.search
  end

end
