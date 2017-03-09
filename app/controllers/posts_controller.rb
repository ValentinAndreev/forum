class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.all
  end

  def show ; end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was created'
    else
      render 'new'
    end
  end

  def edit ; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was updated'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was deleted'
  end

  private

  def post_params
    params.require(:post).permit(:name, :text)
  end

  def set_post
    @post = Post.find(params[:id]) if params[:id]
  end
end
