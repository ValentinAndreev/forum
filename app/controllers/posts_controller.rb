class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.js
    end  
  end

  def show ; end

  def edit ; end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create!(post_params)
  end

  def update
    @post.update_attributes!(post_params)
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:name, :text)
  end

  def set_post
    @post = Post.find(params[:id]) if params[:id]
  end
end
