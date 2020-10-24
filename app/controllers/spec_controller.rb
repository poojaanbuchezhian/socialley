class SpecController < ApplicationController
  before_action :protect
  def index
    redirect_to :controller => "user", :action => "index"
  end

  def edit
    @title = "Edit Spec"
    @user = User.find(session[:user_id])
    @user.spec ||= Spec.new
    @spec = @user.spec
    if param_posted?(:spec)
      if @user.spec.update_attributes(params[:spec])
        flash[:notice] = "Changes saved."
        redirect_to :controller => "user", :action => "index"
      end
    end
  end
end
