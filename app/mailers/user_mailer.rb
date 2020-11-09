class UserMailer < ApplicationMailer
  def reminder
    @user=params[:user]
    @subject = 'Your login information at Socialley.com'
    @body = {}
    @body["user"] = @user
    @recipients = @user.email
    @from = 'Socialley <do-not-reply@socialley.com>'
    mail(to: @recipients, subject: @subject, from: @from)
  end
  def messaging
    @user=params[:recipient]
    @sender=params[:sender]
    @message = params[:message]
    @reply_url = params[:reply_url]
    @user_url = params[:user_url]
    @subject = @message.subject
    @body = {}
    @body["user"] = @user
    @recipients = @user.email
    @from = 'Socialley <do-not-reply@socialley.com>'
    mail(to: @recipients, subject: @subject, from: @from)
  end
  def friend_request
    @user=params[:user]
    @friend =params[:friend]
    @user_url = params[:user_url]
    @accept_url = params[:accept_url]
    @decline_url = params[:decline_url]
    @subject = 'New friend request at Socialley.com'
    @from = 'Socialley <do-not-reply@socialley.com>'
    @recipients = @friend.email
    @body = {}
    @body["user"] = @user
    mail(to: @recipients, subject: @subject, from: @from)
  end
end
