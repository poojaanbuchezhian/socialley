require 'test_helper'

class EmailControllerTest < ActionDispatch::IntegrationTest
  test "should get remind" do
    get email_remind_url
    assert_response :success
  end

end
