require 'digest/sha1'
class UserController < ApplicationController
  include ApplicationHelper
  ActionController::Parameters.permit_all_parameters = true
  helper :profile,  :avatar
  before_action :protect, :only =>  [:index, :edit,  :edit_password]

  private def remember_me_string
    cookies[:remember_me] || "0"
  end
  def index
    @title = "Socialley User Hub"
    @user = User.find(session[:user_id])
    make_profile_vars
  end
  private def user_params
    params.require(:user).permit(:screen_name,:email,:password)
  end
  private def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "User #{attribute} updated."
      redirect_to :action => "index"
    end
  end
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end
  def register
    @title = "Register"
    if param_posted?(:user)
        @user = User.new(user_params)
        if @user.save
          flash[:notice] = "User #{@user.screen_name} created!"
          @user.login!(session)
          redirect_to_forwarding_url
        else
            @user.clear_password!
        end
    end
  end
  def login
    @title = "Log in to Socialley"
    if request.get?
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,@user.password)
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        flash[:notice] = "User #{user.screen_name} logged in!"
        redirect_to_forwarding_url
      else
        @user.clear_password!
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end
  def logout
    User.logout!(session,cookies)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "site"
  end
  def edit
    @title = "Edit basic info"
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end
      end
    end
    @user.clear_password!
  end
end
