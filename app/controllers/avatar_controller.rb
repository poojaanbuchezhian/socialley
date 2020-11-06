class AvatarController < ApplicationController
  before_action :protect
  skip_before_action :verify_authenticity_token
  def index
    redirect_to :controller => "user", :action => "index"
  end

  def upload
    @title = "Upload Your Avatar"
    @user = User.find(session[:user_id])
    if param_posted?(:avatar)
      image = params[:avatar][:image]
      @avatar = Avatar.new(@user, image)
      if @avatar.save
        flash[:notice] = "Your avatar has been uploaded."
        redirect_to :controller => "user", :action => "index"
      end
    end
  end

  def delete
    user = User.find(session[:user_id])
    user.avatar.delete
    flash[:notice] = "Your avatar has been deleted."
    redirect_to :controller => "user", :action => "index"
  end
end
