require 'test_helper'

class SpecControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spec_index_url
    assert_response :success
  end

  test "should get edit" do
    get spec_edit_url
    assert_response :success
  end

end
