defmodule Artour.PublicCategoryView do
  use Artour.Web, :view
  import Artour.CategoryView, only: [display_name: 1]

  @doc """
  Renders page of list of related posts on public site
  """
  def render("show.html", assigns) do
    category = assigns[:category]

    render Artour.PublicSharedView, "post_listing.html", conn: assigns[:conn], title: display_name(category), posts: category.posts
  end

  @doc """
  Used to get the path for a category's public show page
  """
  def show_path(conn, category) do
    public_category_path(conn, :show, category.slug)
  end

end
