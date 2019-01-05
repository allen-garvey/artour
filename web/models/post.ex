defmodule Artour.Post do
  use Artour.Web, :model
  import Artour.SlugValidator, only: [validate_slug: 2]

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :body, :string
    field :is_nsfw, :boolean, default: false
    field :is_markdown, :boolean, default: false

    belongs_to :category, Artour.Category
    belongs_to :cover_image, Artour.Image

    many_to_many :images, Artour.Image, join_through: "post_images", on_delete: :delete_all
    many_to_many :tags, Artour.Tag, join_through: "post_tags", on_delete: :delete_all
    timestamps()
  end

  @doc """
  Returns string datetime of when post was created
  """
  def date_created(post) do
    post.inserted_at 
  end

  @doc """
  Query used for default order
  """
  def default_order_query() do
    from(Artour.Post, order_by: [desc: :id])
  end

  @doc """
  Get all images in Post's album in correct album order
  """
  def album_post_images(repo, post) do
    from(pi in Artour.PostImage, where: pi.post_id == ^post.id, order_by: [pi.order, pi.id])
      |> repo.all
      |> repo.preload([:image])
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :body, :category_id, :cover_image_id, :is_nsfw, :is_markdown])
    |> validate_required([:title, :slug, :category_id, :cover_image_id, :is_nsfw, :is_markdown])
    |> assoc_constraint(:category)
    |> assoc_constraint(:cover_image)
    |> validate_slug(:slug)
    |> unique_constraint(:title)
    |> unique_constraint(:slug)
  end
end
