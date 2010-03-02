require "rubygems"
require "sequel"

abort "env DATABASE_URL is not set" unless ENV.has_key? 'DATABASE_URL'

begin
  db = Sequel.connect(ENV['DATABASE_URL'])
  abort "Invalid database state" unless db.tables == []
rescue Sequel::DatabaseConnectionError
  abort "Could not connect to #{ENV['DATABASE_URL']}"
end

puts "Heroku integration test complete without errors"