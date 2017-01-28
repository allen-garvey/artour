defmodule Distill.Post do
  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def post_routes() do
    Artour.Repo.all(Artour.Post) |> Enum.map(&post_to_route/1)
  end

  @doc """
  Takes a post struct and returns route tuple
  """
  def post_to_route(post) do
    {"/posts/" <> post.slug, Artour.PublicPostController, :show, %{"slug" => post.slug}}
  end
end