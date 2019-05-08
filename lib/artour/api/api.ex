defmodule Artour.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo
  alias Artour.Admin

  # alias Artour.Post
  alias Artour.Tag
  # alias Artour.Category
  alias Artour.Image
  alias Artour.PostImage
  alias Artour.PostTag

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

  @doc """
  Reorder images for post
  """
  def reorder_post_images(post_images) when is_list(post_images) do
    Repo.transaction(fn ->
      for {post_image_id, i} <- post_images |> Enum.with_index do
        now = DateTime.utc_now() |> DateTime.truncate(:second)
        {1, nil} = from(
                        post_image in PostImage,
                        where: post_image.id == ^post_image_id
                      )
        |> Repo.update_all(set: [order: i, updated_at: now])
      end
    end)
  end

  def unused_tags_for_post(post_id) do
    post_tags_subquery = from(post_tag in PostTag, where: post_tag.post_id == ^post_id)

    from(
      t in Tag,
      left_join: post_tag in subquery(post_tags_subquery),
      on: t.id == post_tag.tag_id,
      where: is_nil(post_tag.tag_id),
      order_by: t.name
    )
    |> Repo.all

  end

end
