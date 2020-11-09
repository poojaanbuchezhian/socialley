class PostsController < ApplicationController
  helper :profile
  before_action :protect, :protect_blog
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], per_page: 10)
    @title = "Blog Management"
    respond_to do |format|
     format.html # index.html.erb
     format.json  { render :json => @posts }
   end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @title = @post.title

    respond_to do |format|
     format.html # index.html.erb
     format.json  { render :json => @post }
   end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @title = "Add a new post"
  end

  # GET /posts/1/edit
  def edit
    @title = "Edit #{@post.title}"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if  @blog.posts << @post
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to :id =>@post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, :location =>@post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to :id =>@post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, :location =>@post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      flash[:notice] = 'Post was successfully destroyed.'
      format.html { redirect_to :controller => "user", :action => "index", notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:blog_id, :title, :body)
    end
    def protect_blog
      @blog = Blog.find(params[:blog_id])
      user = User.find(session[:user_id])
    end
end
