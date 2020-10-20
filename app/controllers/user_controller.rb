class UserController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true
  def index
    @title = "RailsSpace User Hub"
  end
  private def user_params
    params.require(:user).permit(:screen_name,:email,:password)
  end
  def register
    @title = "Register"
    if request.post? and params[:user]
        @user = User.new(user_params)
        if @user.save
          flash[:notice] = "User #{@user.screen_name} created!"
          redirect_to :action => "index"
        end
      end
    end
  end
