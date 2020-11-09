require 'digest/sha1'
class User < ApplicationRecord
  has_one :spec
  has_one :faq
  has_one :blog
  has_many :friendships
  has_many :friends, -> { where "status = 'accepted'","order('screen_name')"},
           through: :friendships
 has_many :requested_friends, -> { where "status = 'requested'","order('created_at')"},
            :through => :friendships,
            :source => :friend
  has_many :pending_friends, -> { where "status = 'pending'","order('created_at')"},
          :through => :friendships,
          :source => :friend
  acts_as_indexed :fields => ['screen_name', 'email']
  attr_accessor :remember_me
  attr_accessor :current_password
  SCREEN_NAME_MIN_LENGTH = 4
  SCREEN_NAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40
  EMAIL_MAX_LENGTH = 50
  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

  SCREEN_NAME_SIZE = 20
  PASSWORD_SIZE = 10
  EMAIL_SIZE = 30

  validates_uniqueness_of :screen_name, :email
  validates_confirmation_of :password
  validates_length_of :screen_name, :within => SCREEN_NAME_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE
  validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
  validates_format_of :screen_name,
                      :with => /\A[A-Z0-9_]*\z/i,
                      :message => "must contain only letters, " +
                                  "numbers, and underscores"
  validates_format_of :email,
                      :with => /\A[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i,
                      :message => "must be a valid email address"
  def login!(session)
      session[:user_id] = id
  end
  def avatar
    Avatar.new(self)
  end
  def self.logout!(session,cookies)
    session[:user_id] = nil
    cookies.delete(:authorization_token)
  end
  def clear_password!
    self.password = nil
  end
  def remember!(cookies)
    cookie_expiration = 10.years.from_now
    cookies[:remember_me] = { :value => "1",
                              :expires => cookie_expiration }
    self.authorization_token =  unique_identifier
    save!
    cookies[:authorization_token] = { :value => authorization_token,
                                      :expires => cookie_expiration }
  end
  private def unique_identifier
    Digest::SHA1.hexdigest("#{screen_name}:#{password}")
  end
  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end
  def remember_me?
    remember_me == "1"
  end
  def clear_password!
    self.password = nil
    self.password_confirmation = nil
    self.current_password = nil
  end
  def correct_password?(params)
    current_password = params[:user][:current_password]
    password == current_password
  end
  def password_errors(params)
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    valid?
    errors.add(:current_password, "is incorrect")
  end
  def name
    spec.full_name.or_else(screen_name)
  end

end
