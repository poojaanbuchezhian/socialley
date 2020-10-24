require 'test_helper'

class FaqControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get faq_index_url
    assert_response :success
  end

  test "should get edit" do
    get faq_edit_url
    assert_response :success
  end

end
