defmodule Artour.PageController do
  use Artour.Web, :controller

  def index(conn, _params) do
  	posts = Repo.all(from(Artour.Post, order_by: [desc: :id])) |> Repo.preload([:category])
    render conn, "index.html", posts: posts
  end

  def browse(conn, _params) do
  	categories = Repo.all(Artour.Category.default_order_query())
    render conn, "browse.html", categories: categories
  end
end
