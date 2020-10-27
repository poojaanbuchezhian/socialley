require 'test_helper'

class CommunityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get community_index_url
    assert_response :success
  end

  test "should get browse" do
    get community_browse_url
    assert_response :success
  end

  test "should get search" do
    get community_search_url
    assert_response :success
  end

end
