require_relative 'contact'
arg1, arg2 = ARGV

case arg1
when "help"
  print "Here is a list of available commands:
    new - Create a new contact
    lastname - Find a contact by last name
    firstname - Find a contact by first name
    find - Find a contact by ID
    delete - Deletes contact"
when "new"
  print "Enter first name of contact: "
  firstname = STDIN.gets.chomp
  print "Enter last name of contact: "
  lastname = STDIN.gets.chomp
  print "Enter email of contact: "
  email = STDIN.gets.chomp
  contact = Contact.new(firstname,lastname,email)
  contact.save
when "find" 
  result = Contact.find(arg2)
  Contact.display_search_result(result)
when "lastname"
  result = Contact.find_all_by_lastname(arg2)
  Contact.display_search_result(result)
when "firstname"
  result = Contact.find_all_by_firstname(arg2)
  Contact.display_search_result(result)
when "delete"
  print "Enter the id of the person you would like to delete: "
  id = STDIN.gets.chomp.to_i
  if Contact.find(id) # check if it exists
    record_to_delete = Contact.new()
    record_to_delete.id = id
    record_to_delete.destroy
  else
    puts "That ID does not exist." # doesn't work...yet
  end
else
  puts "nothing happened"
end
