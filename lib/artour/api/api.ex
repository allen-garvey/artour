defmodule Artour.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo
  alias Artour.Admin

  # alias Artour.Post
  # alias Artour.Tag
  # alias Artour.Category
  alias Artour.Image
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

  @doc """
  Creates images
  returns [changeset|nil] array of changesets for images with errors, or nil if image has no errors
  if successful, will return whatever Repo.transaction returns, which I believe is nil
  """
  def create_images(images) do
    Repo.transaction(fn ->
      {status, errors} = Enum.reduce(images, {:ok, []}, fn image, {status, errors} ->
        case Admin.create_image(image) do
          {:ok, %Image{} = _image} -> {status, [nil | errors]}
          {:error, changeset}      -> {:error, [changeset | errors]}
        end
      end)
      if status == :error do
        Enum.reverse(errors)
        |> Repo.rollback
      end
    end)
  end

end
