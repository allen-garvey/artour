defmodule Artour.PublicTagController do
  use Artour.Web, :controller

  alias Artour.Tag

  def index(conn, _params) do
    tags = Tag.all_with_posts Repo
    render(conn, "index.html", tags: tags)
  end

  def show(conn, %{"slug" => slug}) do
    tag = Repo.get_by!(Tag, slug: slug) |> Repo.preload(posts: from(p in Artour.Post, order_by: [desc: :id]))
    render(conn, "show.html", tag: tag)
  end

end
