class HomeController < ApplicationController
  def welcome
    @data = { email: current_user.email, posts: current_user.posts.count, comments: current_user.comments.count, admin: current_user.admin } if current_user
  end
end
