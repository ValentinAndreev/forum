class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post

  def index
    @search = Post.search(params[:q])
    @searched_posts = @search.result
    @posts = Post.paginate(:page => params[:page], :per_page => 3)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comments = @post.comments.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit ; end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    render 'new' unless @post.save
  end

  def update
    @post.update(post_params)
    render 'edit' unless @post.update(post_params)
  end

  def destroy
    @post.destroy
    redirect_to posts_path if current_user.admin
  end

  private

  def post_params
    params.require(:post).permit(:name, :text)
  end

  def set_post
    @post = Post.find(params[:id]) if params[:id]
  end
end
