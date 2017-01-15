defmodule Artour.Format do
  use Artour.Web, :model

  schema "formats" do
    field :name, :string

    timestamps()
  end

  @doc """
  Query used for default order
  """
  def default_order_query() do
    from(f in Artour.Format, order_by: f.name)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  @doc """
  Maps a list of formats into tuples, used for forms
  """
  def map_for_form(formats) do
    Enum.map(formats, &{&1.name, &1.id})
  end

  @doc """
  Returns list of formats with name and id
  ordered in default order suitable for select fields
  for forms
  """
  def form_list(repo) do
    repo.all(default_order_query()) |> map_for_form
  end

end
