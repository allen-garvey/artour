defmodule Artour.ApiImageView do
  use Artour.Web, :view

  alias Artour.ImageView
  alias Artour.ChangesetView

  @doc """
  Renders individual image instance to json
  Used for adding images to post api route
  key has to be api_image, not image, because that is how
  render_many and render work by default
  """
  def render("image_thumbnail_excerpt.json", %{api_image: image}) do
    %{
      id: image.id,
      title: image.title,
      description: image.description,
      url: %{
        self: image_path(Artour.Endpoint, :show, image),
        thumbnail: ImageView.url_for(Artour.Endpoint, image, :thumbnail, :local)
      },
    }
  end

  def render("errors.json", %{errors: errors}) do
    # TODO put errors at correct index in list
    errors_list = Map.to_list(errors)
    |> Enum.map(fn {_index, changeset} -> changeset end)

    %{data: render_many(errors_list, ChangesetView, "error.json")}
  end
end
