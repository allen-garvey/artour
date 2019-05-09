defmodule Artour.ApiPostController do
  use Artour.Web, :controller

  alias Artour.Api

  @doc """
  Returns list of all tags unused by a post
  """
  def tags_for(conn, %{"post_id" => post_id, "unused" => "true"}) do
    tags = Api.unused_tags_for_post(post_id)
    render(conn, "tags_list.json", tags: tags)
  end

  def tags_for(conn, %{"post_id" => post_id}) do
    tags = Api.tags_for_post(post_id)
    render(conn, "tags_list.json", tags: tags)
  end

  @doc """
  Adds tags to a post
  tags json list of tag ids
  """
  def add_tags(conn, %{"post_id" => post_id, "tags" => tags}) do
    Api.create_post_tags(post_id, tags)
    render(conn, "ok.json", message: "Tags added to post")
  end

  @doc """
  Removes a tag from a post
  """
  def remove_tag(conn, %{"post_id" => post_id, "tag_id" => tag_id}) do
    post_tag = Repo.get_by!(Artour.PostTag, post_id: post_id, tag_id: tag_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post_tag)

    # send_resp(conn, :no_content, "")
    render(conn, "ok.json", message: "Post tag deleted")
  end

  @doc """
  Update attributes of post
  right now only used for cover_image_id
  """
  def update(conn, %{"post_id" => post_id, "cover_image_id" => cover_image_id}) do
    post = Repo.get!(Artour.Post, post_id)
    post = Ecto.Changeset.change post, cover_image_id: cover_image_id
    case Repo.update post do
      {:ok, _struct}       -> render(conn, "ok.json", message: "Post cover_image_id updated")
      {:error, _changeset} -> render(conn, "error.json", message: "Error changing post cover_image_id")
    end
  end

  @doc """
  Returns list of all of a post's images
  """
  def post_images(conn, %{"post_id" => post_id}) do
    post_images = Api.list_post_images_for_post(post_id)
    render(conn, "post_images_list.json", post_images: post_images)
  end

  @doc """
  Reorder post album images
  """
  def reorder_images(conn, %{"post_id" => _post_id, "post_images" => post_images}) do
    Api.reorder_post_images(post_images)
    render(conn, "ok.json", message: "Post image order updated")
   end

  @doc """
  Gets images that can be added to post
  """
  def add_images(conn, %{"post" => post_id, "unused" => _unused}) do
    image_ids_used = Repo.all(from(pi in Artour.PostImage, select: pi.image_id))

    images_addable_to_post(conn, post_id, image_ids_used)
  end

  def add_images(conn, %{"post" => post_id}) do
    image_ids_used = Repo.all(from(pi in Artour.PostImage, select: pi.image_id, where: pi.post_id == ^post_id))

    images_addable_to_post(conn, post_id, image_ids_used)
  end

  defp images_addable_to_post(conn, _post_id, image_ids_used) do
    unused_images = Repo.all(from(i in Artour.Image, where: not(i.id in ^image_ids_used), order_by: [desc: i.id]))

    render conn, "image_excerpts.json", images: unused_images
  end
end
