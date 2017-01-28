defmodule Distill.Post do
  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def routes() do
    Artour.Repo.all(Artour.Post) |> Enum.map(&to_route/1)
  end

  @doc """
  Takes a post struct and returns route tuple
  """
  def to_route(post) do
    {"/posts/" <> post.slug, Artour.PublicPostController, :show, %{"slug" => post.slug}}
  end
end