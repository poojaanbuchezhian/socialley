class ProfileController < ApplicationController
  before_action :protect
  helper :avatar,  :friendship
  def index
    @title = "Socialley Profiles"
  end

  def show
    @hide_edit_links = true
    screen_name = params[:screen_name]
    @user = User.find_by_screen_name(screen_name)
    @logged_in_user = User.find(session[:user_id]) if logged_in?
    if @user
      @title = "My Socialley Profile for #{screen_name}"
      make_profile_vars
    else
      flash[:notice] = "No user #{screen_name} at Socialley!"
      redirect_to :action => "index"
    end
  end
end
