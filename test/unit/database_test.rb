require 'test_helper'

class DatabaseTest < ActiveSupport::TestCase
  def setup
    @db = Database.create
  end

  test "assigns a name" do
    assert @db.name
    assert @db.name.size => 8
  end

  test "assigns a password" do
    assert @db.password
    assert @db.password.size => 8
  end

  test "has a url" do
    @db.id = 'mydb'
    @db.password = 'secret'
    assert_equal "mysql://#{Database::PREFIX}mydb:secret@localhost/#{Database::PREFIX}mydb", @db.url
  end

  test "is included in Database.all" do
    assert Database.all.map(&:id).include?(@db.id)
  end

  test "is deleted" do
    @db.destroy
    assert !Database.all.map(&:id).include?(@db.id)
  end
end
