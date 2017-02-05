defmodule Artour.PublicPostController do
  use Artour.Web, :controller

  alias Artour.Post

  @doc """
  Used on public site to show all posts in reverse chronological order
  """
  def index(conn, _params) do
    posts = Repo.all(from(Post, order_by: [desc: :id]))
    render(conn, "index.html", posts: posts)
  end

  @doc """
  Used on public site to show individual post
  """
  def show(conn, %{"slug" => slug}) do
    post = Repo.get_by!(Post, slug: slug) |> Repo.preload([:category]) |> Repo.preload(tags: from(Artour.Tag, order_by: :name))
    post_images = Post.album_post_images(Repo, post)
    render(conn, "show.html", post: post, post_images: post_images, javascript: true)
  end

  
end
