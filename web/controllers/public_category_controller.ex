defmodule Artour.PublicCategoryController do
  use Artour.Web, :controller

  alias Artour.Category

  def index(conn, _params) do
    categories = Category.all_with_posts Repo
    render conn, "index.html", page_title: "Categories", categories: categories
  end

  @doc """
  Used on public site to show listing of
  individual category's posts
  """
  def show(conn, %{"slug" => slug}) do
    category = Repo.get_by!(Category, slug: slug) |> Repo.preload(posts: from(Artour.Post, order_by: [desc: :id]))
    render conn, "show.html", page_title: Artour.CategoryView.display_name(category), category: category
  end

end
