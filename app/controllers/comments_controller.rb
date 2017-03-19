class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, except: :dashboard

  def dashboard
    @search = Comment.search(params[:q])
    @searched_comments = @search.result
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    render 'new' unless @comment.save
  end

  def update
    @comment.update(comment_params)
    render 'edit' unless @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was deleted' if current_user.admin }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_comment
    @post = Post.find(params[:post_id]) if params[:post_id]
    @comment = @post.comments.find(params[:id]) if params[:id]
    @comments = @post.comments.all
  end
end
