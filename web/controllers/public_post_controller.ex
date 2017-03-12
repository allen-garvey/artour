defmodule Artour.PublicPostController do
  use Artour.Web, :controller

  alias Artour.Post

  @doc """
  Used on public site to show all posts in reverse chronological order
  """
  def index(conn, _params) do
    posts = Repo.all(from(Post, order_by: [desc: :id]))
    render conn, "index.html", page_title: "Posts", posts: posts 
  end

  @doc """
  Used on public site to show individual post
  """
  def show(conn, %{"slug" => slug}) do
    post = Repo.get_by!(Post, slug: slug) |> Repo.preload([:category, :cover_image]) |> Repo.preload(tags: from(Artour.Tag, order_by: :name))
    post_images = Post.album_post_images(Repo, post)
    render conn, "show.html", page_title: Artour.PostView.display_name(post), post: post, post_images: post_images, javascript: true, facebook_image: post.cover_image 
  end

  
end
