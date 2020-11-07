class EmailController < ApplicationController
  include ProfileHelper
  before_action :protect, :only => [ "correspond" ]
  def remind
    @title = "Mail me my login information"
    if param_posted?(:user)
      email = params[:user][:email]
      user = User.find_by_email(email)
      if user
        UserMailer.with(user: user).reminder.deliver_now
        flash[:notice] = "Login information was sent."
        redirect_to  :controller => "user",:action => "login"
      else
        flash[:notice] = "There is no user with that email address."
      end
    end
  end
  def correspond
    sender = User.find(session[:user_id])
    recipient = User.find_by_screen_name(params[:screen_name])
    @title = "Email #{recipient.screen_name}"
    if param_posted?(:message)
      @message = Message.new(params[:message])
      if @message.valid?
        UserMailer.with(sender: sender, recipient: recipient, message: @message,
           user_url: url_for(:controller => "profile", :action => "show" , :screen_name => sender.screen_name),
           reply_url:  url_for(:action => "correspond",
:screen_name => sender.screen_name) ).messaging.deliver_now
        flash[:notice] = "Email sent."
        redirect_to :controller => "profile", :action => "show" , :screen_name => recipient.screen_name
      end
    end
  end
end
