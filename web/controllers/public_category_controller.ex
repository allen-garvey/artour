defmodule Artour.PublicCategoryController do
  use Artour.Web, :controller

  alias Artour.Category

  def index(conn, _params) do
    categories = Category.all_with_posts Repo
    render(conn, "index.html", categories: categories)
  end

  @doc """
  Used on public site to show listing of
  individual category's posts
  """
  def show(conn, %{"slug" => slug}) do
    category = Repo.get_by!(Category, slug: slug) |> Repo.preload(posts: from(p in Artour.Post, order_by: [desc: :id]))
    render(conn, "show.html", category: category)
  end

end
