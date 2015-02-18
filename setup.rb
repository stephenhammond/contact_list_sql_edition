require 'pry' # incase you want to use binding.pry
require 'active_record'
require_relative 'lib/main'
require_relative 'lib/contact'
 
# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)
 
puts "Establishing connection to database ..."
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
puts "CONNECTED"
 
puts "Setting up Database (recreating tables) ..."
 
ActiveRecord::Schema.define do
  drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
 
  create_table :contacts do |t|
    t.column :firstname, :string
    t.column :lastname, :string
    t.column :email, :string
    t.timestamps
  end
 
  # create_table :posts do |table|
  #   table.references :user
  #   table.column :title, :string
  #   table.column :body, :string
  #   table.column :published, :boolean
  #   table.timestamps
  # end
  
end
 
puts "Setup DONE"