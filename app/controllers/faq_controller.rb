class FaqController < ApplicationController
  before_action :protect
  def index
  end

  def edit
    @title = "Edit FAQ"
    @user = User.find(session[:user_id])
    @faq = @user.faq ||= Faq.new
    if param_posted?(:faq)
      if @user.faq.update_attributes(params[:faq])
        flash[:notice] = "FAQ saved"
        redirect_to  :controller => "user",:action => "index"
      end
    end
  end
end
