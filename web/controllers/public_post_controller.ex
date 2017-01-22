defmodule Artour.PublicPostController do
  use Artour.Web, :controller

  alias Artour.Post

  @doc """
  Used on public site to show individual post
  """
  def show(conn, %{"slug" => slug}) do
    post = Repo.get_by!(Post, slug: slug) |> Repo.preload([:category])
    post_images = Post.album_post_images(Repo, post)
    render(conn, "show_album.html", post: post, post_images: post_images)
  end

  
end
