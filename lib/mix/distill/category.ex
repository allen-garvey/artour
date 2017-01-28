defmodule Distill.Category do
  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def routes() do
    Artour.Repo |> Artour.Category.all_with_posts |> Enum.map(&to_route/1)
  end

  @doc """
  Takes a category struct and returns route tuple
  """
  def to_route(category) do
    {"/categories/" <> category.slug, Artour.PublicCategoryController, :show, %{"slug" => category.slug}}
  end
end