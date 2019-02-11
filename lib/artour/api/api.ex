defmodule Artour.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo

  # alias Artour.Post
  # alias Artour.Tag
  # alias Artour.Category
  # alias Artour.Image
  alias Artour.PostImage
  # alias Artour.PostTag

  @doc """
  Returns the list of a post's post images
  """
  def list_post_images_for_post(post_id) do
    from(
          pi in PostImage,
          join: image in assoc(pi, :image),
          preload: [image: image],
          where: pi.post_id == ^post_id,
          order_by: [pi.order, pi.id]
        )
    |> Repo.all
  end

end
