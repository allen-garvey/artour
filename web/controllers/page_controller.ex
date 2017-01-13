defmodule Artour.PageController do
  use Artour.Web, :controller

  def index(conn, _params) do
  	posts = Repo.all(from(Artour.Post, order_by: [desc: :id])) |> Repo.preload([:category])
    render conn, "index.html", posts: posts
  end
end
