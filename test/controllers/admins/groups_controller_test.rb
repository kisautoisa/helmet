require "test_helper"

class Admins::GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admins_groups_edit_url
    assert_response :success
  end
end
