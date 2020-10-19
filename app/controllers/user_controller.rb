class UserController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true
  def index
  end
  private def user_params
    params.require(:user).permit(:user)
  end
  def register
    @title = "Register"
    if request.post? and params[:user]
        @user = User.new(user_params)
        if @user.save
          render :text => "User created!"
        end
    end
end
end
