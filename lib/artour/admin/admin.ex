defmodule Artour.Admin do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo

  alias Artour.Post
  alias Artour.Tag
  # alias Artour.Category
  # alias Artour.Image
  alias Artour.PostImage

  @doc """
  Returns the list of posts.
  """
  def list_posts do
    from(
          p in Post, 
          join: category in assoc(p, :category), 
          join: cover_image in assoc(p, :cover_image), 
          preload: [category: category, cover_image: cover_image],
          order_by: [desc: :id]
        )
    |> Repo.all
  end


  @doc """
  Gets a single post by id

  Raises `Ecto.NoResultsError` if the Post does not exist.
  """
  def get_post_for_show!(id) do
    from(
          p in Post, 
          join: category in assoc(p, :category), 
          where: p.id == ^id, 
          preload: [category: category]
        )
    |> Repo.one!
    |> Repo.preload(tags: from(Tag, order_by: :name))
    |> Repo.preload(post_images: from(pi in PostImage, join: image in assoc(pi, :image), preload: [image: image], order_by: [pi.order, pi.id]))
  end

end
