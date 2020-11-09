class CommentsController < ApplicationController
  helper :profile, :avatar
  include ProfileHelper
  before_action :protect, :load_post
  skip_before_action :verify_authenticity_token

  def new
    @comment = Comment.new
    respond_to do |format|
     format.html
     format.js
   end
 end
  def create
   @comment = Comment.new(params[:comment])
   @comment.user = User.find(session[:user_id])
   @comment.post = @post

   respond_to do |format|
     if @comment.duplicate? or @post.comments << @comment
       flash[:notice] = 'Commented successfully.'
       format.js { redirect_to url_for(:controller => "user", :action => "index")}
       format.html { redirect_to url_for(:controller => "profile", :action => "show" , :screen_name => @post.blog.user.screen_name) }
     else
       format.html { redirect_to new_blog_post_comment_url(@post.blog, @post) }
       format.js { render :nothing => true }
     end
   end
 end
 def destroy
    @comment = Comment.find(params[:id])
    user = User.find(session[:user_id])
    if @comment.authorized?(user)
      @comment.destroy
    else
      redirect_to :controller => "user", :action => "index"
      return
    end
    respond_to do |format|
      flash[:notice] = 'Comment was successfully destroyed.'
      format.html { redirect_to :controller => "user", :action => "index", notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private def load_post
    @post = Post.find(params[:post_id])
  end
end
