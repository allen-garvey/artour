defmodule Artour.PageController do
  use Artour.Web, :controller

  def index(conn, _params) do
  	posts = Repo.all(from(Artour.Post, order_by: [desc: :id])) |> Repo.preload([:category, :cover_image])
    render conn, "index.html", posts: posts
  end

  @doc """
  Shows list of categories that contain 1 or more related posts
  """
  def browse(conn, _params) do
  	category_id_subquery = Repo.all(from(p in Artour.Post, distinct: true, select: p.category_id))
  	categories = Repo.all(from c in Artour.Category, where: c.id in ^category_id_subquery, order_by: c.name)
    
    render conn, "browse.html", categories: categories
  end
end
