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
  	category_ids_subquery = Repo.all(from(p in Artour.Post, distinct: true, select: p.category_id))
  	categories = Repo.all(from c in Artour.Category, where: c.id in ^category_ids_subquery, order_by: c.name)

    tag_ids_subquery = Repo.all(from(pt in Artour.PostTag, distinct: true, select: pt.tag_id))
    tags = Repo.all(from t in Artour.Tag, where: t.id in ^tag_ids_subquery, order_by: t.name)
    
    render conn, "browse.html", categories: categories, tags: tags
  end
end
