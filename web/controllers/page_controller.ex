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
  	
  	categories = Artour.Category.all_with_posts Repo
    tags = Artour.Tag.all_with_posts Repo 
    
    render conn, "browse.html", categories: categories, tags: tags
  end

  @doc """
  Displays 404 page
  """
  def error_404(conn, _params) do
    render conn, "404.html"
  end
end
