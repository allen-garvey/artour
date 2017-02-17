defmodule Artour.PublicTagController do
  use Artour.Web, :controller

  alias Artour.Tag

  def index(conn, _params) do
    tags = Tag.all_with_posts Repo
    render conn, "index.html", page_title: "Tags",  tags: tags
  end

  def show(conn, %{"slug" => slug}) do
    tag = Repo.get_by!(Tag, slug: slug) |> Repo.preload(posts: from(Artour.Post, order_by: [desc: :id]))
    render conn, "show.html", page_title: Artour.TagView.display_name(tag),  tag: tag 
  end

end
