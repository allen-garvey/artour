defmodule Artour.PublicPostView do
  use Artour.Web, :view

  @doc """
  Used to get the path for a post's public show page
  """
  def show_path(conn, post) do
    public_post_path(conn, :show, post.slug)
  end

  @doc """
  Renders page of list of all posts in 
  """
  def render("index.html", assigns) do
    posts = assigns[:posts]
    render Artour.PublicSharedView, "post_listing.html", conn: assigns[:conn], title: "All Posts", posts: posts
  end
end
