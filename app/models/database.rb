class Database
  PREFIX = 'mso_'

  class Error < RuntimeError; end

  def self.db
    @@db ||= ActiveRecord::Base.connection
  end

  def self.all
    db.select_all("SHOW DATABASES").map do |res|
      res['Database']
    end.map do |db|
      if db =~ /^#{PREFIX}(\w+)/
        new($1)
      end
    end.compact
  end

  def self.create
    db = new
    db.create
    db.setup_access
    db
  end

  def self.find(id)
    id = id.gsub(PREFIX, '')
    all.detect { |db| db.id == id } || raise(Error)
  end

  attr_accessor :id, :password

  def initialize(id=generate_id)
    @id = id
  end

  def name
    "#{PREFIX}#{id}"
  end

  def create
    db.execute "CREATE DATABASE #{name}"
  end

  def setup_access
    @password = generate_id
    db.execute "CREATE USER '#{name}'@'%' IDENTIFIED BY '#{password}'"
    db.execute "CREATE USER '#{name}'@'localhost' IDENTIFIED BY '#{password}'"
    db.execute "GRANT ALL PRIVILEGES ON #{name}.* TO '#{name}'@'%'"
    db.execute "GRANT ALL PRIVILEGES ON #{name}.* TO '#{name}'@'localhost'"
    db.execute "FLUSH PRIVILEGES"
  end

  def destroy
    db.execute "DROP USER '#{name}'"
    db.execute "DROP DATABASE #{name}"
  end

  def url
    "mysql://#{name}:#{password}@#{ip}/#{name}"
  end

  def attributes
    { :id => id, :password => password }
  end

  def generate_id
    Digest::SHA1.hexdigest(Time.now.to_s + Time.now.usec.to_s)[8, 12]
  end

  def ip
    ENV['MYSQLOMATIC_IP'] || 'localhost'
  end

  def db
    self.class.db
  end
end
