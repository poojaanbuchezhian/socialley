require './test/test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end
  def test_user_validity
    assert @valid_user.valid?
  end
  def test_user_invalidity
    assert !@invalid_user.valid?
    attributes = [:screen_name, :email, :password]
    attributes.each do |attribute|
      assert @invalid_user.invalid?(attribute)
    end
  end
  def test_email_with_valid_examples
    user = @valid_user
    valid_endings = %w{com org net edu es jp info}
    valid_emails = valid_endings.collect do |ending|
      "foo.bar_1-9@baz-quux0.example.#{ending}"
    end
    valid_emails.each do |email|
      user.email = email
      assert user.valid?, "#{email} must be a valid email address"
    end
  end
  def test_email_with_invalid_examples
    user = @valid_user
    invalid_emails = %w{foobar@example.c @example.com f@com foo@bar..com
    foobar@example.infod foobar.example.com
    foo,@example.com foo@ex(ample.com foo@example,com}
    invalid_emails.each do |email|
      user.email = email
      assert !user.valid?, "#{email} tests as valid but shouldn't be"
    end
  end
  def test_screen_name_with_valid_examples
    user = @valid_user
    valid_screen_names = %w{aure michael web_20}
    valid_screen_names.each do |screen_name|
      user.screen_name = screen_name
      assert user.valid?, "#{screen_name} should pass validation, but doesn't"
    end
  end
  def test_screen_name_with_invalid_examples
    user = @valid_user
    invalid_screen_names = %w{rails/rocks web2.0 javscript:something}
    invalid_screen_names.each do |screen_name|
      user.screen_name = screen_name
      assert !user.valid?, "#{screen_name} shouldn't pass validation, but does"
    end
  end
  # test "the truth" do
  #   assert true
  # end
end
