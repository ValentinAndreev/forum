class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, except: :dashboard

  def dashboard
    @search = Post.search(params[:q])
    @searched_posts = @search.result
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3)
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

  def edit; end

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
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was deleted' if current_user.admin }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :text)
  end

  def set_post
    @post = Post.find(params[:id]) if params[:id]
  end
end
