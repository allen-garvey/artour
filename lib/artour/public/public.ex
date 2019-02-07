defmodule Artour.Public do
  @moduledoc """
  The Public context.
  """

  import Ecto.Query, warn: false
  alias Artour.Repo

  alias Artour.Post
  alias Artour.Tag
  alias Artour.Category

  @doc """
  Returns the list of posts.
  """
  def list_posts do
    from(p in Post, where: p.is_published == true, order_by: [desc: :publication_date, desc: :id])
    |> Repo.all
  end


  @doc """
  Gets a single post by slug

  Raises `Ecto.NoResultsError` if the Post does not exist.
  """
  def get_post_by_slug!(slug) do
    from(
          p in Post, 
          join: category in assoc(p, :category), 
          join: cover_image in assoc(p, :cover_image),   
          where: p.slug == ^slug and p.is_published == true, 
          preload: [category: category, cover_image: cover_image]
        )
    |> Repo.one!
    |> Repo.preload(tags: from(Tag, order_by: :name))
  end

end
