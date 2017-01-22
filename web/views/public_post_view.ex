defmodule Artour.PublicPostView do
  use Artour.Web, :view

  @doc """
  Used to get the path for a post's public show page
  """
  def show_path(conn, post) do
    public_post_path(conn, :show, post.slug)
  end
end
