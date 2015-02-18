require_relative 'contact'
arg1, arg2 = ARGV


ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: 'db2d3bms257mhu',
  username: 'zmfmxuskilpfyl',
  password: 'fyQnMUZZ80MO_gxCRrHVVSOLvL',
  host: 'ec2-107-21-93-97.compute-1.amazonaws.com',
  port: 5432,
  min_messages: 'error'
) 

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
  contact = Contact.create(firstname: firstname, lastname: lastname, email: email)
when "find" 
  puts Contact.find(arg2).inspect
when "lastname"
  puts Contact.where(lastname: arg2).inspect
when "firstname"
  puts Contact.where(firstname: arg2).inspect
when "delete"
    print "Enter the id of the person you would like to delete: "
    id = STDIN.gets.chomp.to_i
    Contact.destroy(id)
else
  puts "nothing happened"
end
