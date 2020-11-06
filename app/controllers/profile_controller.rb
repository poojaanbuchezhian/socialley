class ProfileController < ApplicationController
  helper :avatar
  def index
    @title = "Socialley Profiles"
  end

  def show
    @hide_edit_links = true
    screen_name = params[:screen_name]
    @user = User.find_by_screen_name(screen_name)
    if @user
      @title = "My Socialley Profile for #{screen_name}"
      @spec = @user.spec ||= Spec.new
      @faq = @user.faq ||= Faq.new
    else
      flash[:notice] = "No user #{screen_name} at Socialley!"
      redirect_to :action => "index"
    end
  end
end
