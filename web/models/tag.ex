defmodule Artour.Tag do
  use Artour.Web, :model
  import Artour.ModelHelpers.SlugValidator, only: [validate_slug: 2]

  schema "tags" do
    field :name, :string
    field :slug, :string

    many_to_many :posts, Artour.Post, join_through: "post_tags", on_delete: :delete_all
    timestamps()
  end

  @doc """
  Query used for default order
  """
  def default_order_query() do
    from(Artour.Tag, order_by: :name)
  end

  @doc """
  Returns list of all tags associated with at least
  1 post
  """
  def all_with_posts(repo) do
    tag_ids_subquery = repo.all(from(pt in Artour.PostTag, distinct: true, select: pt.tag_id))
    repo.all(from t in Artour.Tag, where: t.id in ^tag_ids_subquery, order_by: t.name)
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug])
    |> validate_required([:name, :slug])
    |> validate_slug(:slug)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end

  @doc """
  Maps a list of tags into tuples, used for forms
  """
  def map_for_form(tags) do
    Enum.map(tags, &{&1.name, &1.id})
  end

  @doc """
  Returns list of tags with name and id
  ordered in default order suitable for select fields
  for forms
  """
  def form_list(repo) do
    repo.all(default_order_query()) |> map_for_form
  end
end
