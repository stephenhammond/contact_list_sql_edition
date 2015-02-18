require 'pg'

class Contact

  attr_accessor :email, :lastname, :id
  attr_reader :name

  def initialize(firstname='', lastname='', email='')
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = 0
  end

  def self.connection
    return @conn if @conn
    @conn = PG.connect( 
      dbname: 'db2d3bms257mhu',
      host: 'ec2-107-21-93-97.compute-1.amazonaws.com',
      user: 'zmfmxuskilpfyl',
      password: 'fyQnMUZZ80MO_gxCRrHVVSOLvL',
      port: 5432
    )
  end

  def self.display_search_result(result)
    result.each do |record|
      puts "Name: #{record['firstname']}" + ' ' + "#{record['lastname']}"
      puts "Email: #{record['email']}"
    end
  end

  def self.find(id)
    find_result = connection.exec_params("SELECT * FROM contacts WHERE id = $1;", [id])
  end

  def self.find_all_by_lastname(name)
    find_result = connection.exec_params("SELECT * FROM contacts WHERE lastname = $1;", [name])
  end

  def self.find_all_by_firstname(name)
    find_result = connection.exec_params("SELECT * FROM contacts WHERE firstname = $1;", [name])
  end

  def self.find_by_email(email)
     find_result = connection.exec_params("SELECT * FROM contacts WHERE email = $1;", [email])
  end

  def save
    if @id == 0
      return_id = self.class.connection.exec_params("INSERT INTO contacts (firstname, lastname, email) VALUES ($1,$2,$3) RETURNING id;", [@firstname, @lastname, @email])
        @id = return_id[id]['id'].to_i
    else
      self.class.connection.exec_params("UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4;", [@firstname, @lastname, @email, @id])
    end
  end

  def destroy 
    self.class.connection.exec_params("DELETE FROM contacts WHERE id = $1;", [@id.to_s])
  end
  
end