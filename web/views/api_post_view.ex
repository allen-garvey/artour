defmodule Artour.ApiPostView do
  use Artour.Web, :view

  @doc """
  Generic ok message, such as for when something is deleted successfully
  """
  def render("ok.json", %{message: message}) do
    %{data: message}
  end

  @doc """
  Used to get all tags for a specific post
  """
  def render("tags_list.json", %{tags: tags}) do
    %{data: render_many(tags, Artour.ApiTagView, "tag.json")}
  end

  # def render("show.json", %{api_post: api_post}) do
  #   %{data: render_one(api_post, Artour.ApiPostView, "api_post.json")}
  # end


end
