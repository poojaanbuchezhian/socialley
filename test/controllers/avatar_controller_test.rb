require 'test_helper'

class AvatarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get avatar_index_url
    assert_response :success
  end

  test "should get upload" do
    get avatar_upload_url
    assert_response :success
  end

  test "should get delete" do
    get avatar_delete_url
    assert_response :success
  end

end
