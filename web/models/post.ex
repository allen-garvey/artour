defmodule Artour.Post do
  use Artour.Web, :model
  import Artour.SlugValidator, only: [validate_slug: 2]

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :body, :string
    belongs_to :category, Artour.Category

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
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :body, :category_id])
    |> validate_required([:title, :slug, :category_id])
    |> foreign_key_constraint(:category_id)
    |> assoc_constraint(:category) #validate category exists
    |> validate_slug(:slug)
    |> unique_constraint(:title)
    |> unique_constraint(:slug)
  end
end
