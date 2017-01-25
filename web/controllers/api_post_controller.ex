defmodule Artour.ApiPostController do
  use Artour.Web, :controller

  @doc """
  Returns list of all tags unused by a post
  """
  def tags_for(conn, %{"post_id" => post_id, "unused" => "true"}) do
    tag_ids_used = Repo.all(from(pt in Artour.PostTag, select: pt.tag_id, where: pt.post_id == ^post_id))
    tags = Repo.all(from(t in Artour.Tag, where: not(t.id in ^tag_ids_used), order_by: t.name))
    render(conn, "tags_list.json", tags: tags)
  end

  @doc """
  Adds tags to a post
  tags json list of tag ids
  """
  def add_tags(conn, %{"post_id" => post_id, "tags" => tags}) do
    for tag_id <- String.split(tags, ",") do
      changeset = Artour.PostTag.changeset(%Artour.PostTag{}, %{"post_id" => post_id, "tag_id" => tag_id})
      Repo.insert!(changeset)   
    end
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
    post = Ecto.Changeset.change post, cover_image_id: String.to_integer(cover_image_id)
    case Repo.update post do
      {:ok, struct}       -> render(conn, "ok.json", message: "Post cover_image_id updated")
      {:error, changeset} -> render(conn, "error.json", message: "Error changing post cover_image_id")
    end
  end
end
