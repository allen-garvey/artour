defmodule Distill.Tag do
  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def routes() do
    Artour.Repo |> Artour.Tag.all_with_posts |> Enum.map(&to_route/1)
  end

  @doc """
  Takes a tag struct and returns route tuple
  """
  def to_route(tag) do
    {"/tags/" <> tag.slug, Artour.PublicTagController, :show, %{"slug" => tag.slug}}
  end
end