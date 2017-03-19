module UsersHelper
  def number_posts(user)
    user.posts.count
  end

  def number_comments(user)
    user.comments.count
  end
end
