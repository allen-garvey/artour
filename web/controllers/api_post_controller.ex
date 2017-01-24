defmodule Artour.ApiPostController do
  use Artour.Web, :controller

  alias Artour.Post

  @doc """
  Returns list of all tags unused by a post
  """
  def tags_for(conn, %{"post_id" => post_id, "unused" => "true"}) do
    tag_ids_used = Repo.all(from(pt in Artour.PostTag, select: pt.tag_id, where: pt.post_id == ^post_id))
    tags = Repo.all(from(t in Artour.Tag, where: not(t.id in ^tag_ids_used), order_by: t.name))
    render(conn, "tags_for_post.json", tags: tags)
  end

  @doc """
  Adds tags to a post
  tags should be a comma-separated list of tag_ids
  """
  def tags_for(conn, %{"post_id" => post_id, "tags" => tags}) do
    
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
end
