defmodule Artour.PublicPostController do
  use Artour.Web, :controller

  alias Artour.Post
  alias Artour.Public

  @doc """
  Used on public site to show all posts in reverse chronological order
  """
  def index(conn, _params) do
    posts = Public.list_posts()
    render conn, "index.html", page_title: "Posts", posts: posts 
  end

  @doc """
  Used on public site to show individual post
  """
  def show(conn, %{"slug" => slug}) do
    post = Public.get_post_by_slug!(slug)
    post_images = Post.album_post_images(Repo, post)
    render conn, "show.html", page_title: Artour.PostView.display_name(post), post: post, post_images: post_images, javascript: true, facebook_image: post.cover_image 
  end

  
end
