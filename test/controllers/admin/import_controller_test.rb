require "test_helper"

class Admin::ImportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_import_index_url
    assert_response :success
  end
end
