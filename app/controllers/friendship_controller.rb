class FriendshipController < ApplicationController
  before_action :protect, :setup_friends

  def create
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:screen_name])
    Friendship.request(@user, @friend)
    UserMailer.with(
    user: @user,
    friend:  @friend,
    user_url: url_for(:controller => "profile", :action => "show" , :screen_name => @user.screen_name),
    accept_url: url_for(:action => "accept", :screen_name => @user.screen_name),
    decline_url: url_for(:action => "decline", :screen_name => @user.screen_name)
  ).friend_request.deliver_now
    flash[:notice] = "Friend request sent."
    redirect_to url_for(:controller => "profile", :action => "show" , :screen_name => @friend.screen_name)
  end
  def accept
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:screen_name])
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.screen_name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.screen_name}."
    end
    redirect_to  :controller => "user", :action => "index"
  end
  def decline
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:screen_name])
    if @user.requested_friends.include?(@friend)
      @user = User.find(session[:user_id])
      @friend = User.find_by_screen_name(params[:screen_name])
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.screen_name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.screen_name}."
    end
    redirect_to :controller => "user", :action => "index"
  end
  def cancel
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:screen_name])
    if @user.pending_friends.include?(@friend)
      @user = User.find(session[:user_id])
      @friend = User.find_by_screen_name(params[:screen_name])
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.screen_name}"
    end
    redirect_to :controller => "user", :action => "index"
  end
  def delete
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:screen_name])
    if @user.friends.include?(@friend)
      @user = User.find(session[:user_id])
      @friend = User.find_by_screen_name(params[:screen_name])
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.screen_name} deleted!"
    else
      flash[:notice] = "You aren't friends with #{@friend.screen_name}"
    end
    redirect_to :controller => "user", :action => "index"
  end
  private def setup_friends
    @user = User.find(session[:user_id])
    @friend = User.find_by_screen_name(params[:id])
  end
end
