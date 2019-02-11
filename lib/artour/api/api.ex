defmodule Artour.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo

  # alias Artour.Post
  # alias Artour.Tag
  # alias Artour.Category
  alias Artour.Image
  alias Artour.PostImage
  # alias Artour.PostTag

  @doc """
  Returns the list of a post's images
  """
  def list_post_images(post_id) do
    from(
          i in Image,
          right_join: post_image in assoc(i, :post_images),
          where: post_image.post_id == ^post_id,
          order_by: [post_image.order, post_image.id]
        )
    |> Repo.all
  end

end
