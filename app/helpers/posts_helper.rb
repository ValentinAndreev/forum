module PostsHelper
  def sanitz(post)
    sanitize post.text, tags: %w(a b i strong em p h1 h2 h3 h4 h5 h6 br hr ul li img pre blockquote), attributes: %w(href name src type value width height style)
  end

  def commts(post)
    post.comments.count
  end
end
