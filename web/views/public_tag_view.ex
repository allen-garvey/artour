defmodule Artour.PublicTagView do
  use Artour.Web, :view
  import Artour.TagView, only: [display_name: 1]

  @doc """
  Renders page of list of related posts on public site
  """
  def render("show.html", assigns) do
    tag = assigns[:tag]

    render Artour.PublicSharedView, "post_listing.html", conn: assigns[:conn], title: display_name(tag), posts: tag.posts
  end

  @doc """
  Used to get the path for a tags's public show page
  """
  def show_path(conn, tag) do
    public_tag_path(conn, :show, tag.slug)
  end
end
