require 'test_helper'

class DatabasesControllerTest < ActionController::TestCase
  test "creates databases" do
    post 'create'
    assert_response :success
    db = JSON.parse(@response.body)
    assert db['id']
  end

  test "destroys databases" do
    db = Database.create
    post 'destroy', :id => db.id
    assert_response :success
  end
end
