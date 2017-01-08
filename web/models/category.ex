defmodule Artour.Category do
  use Artour.Web, :model

  schema "categories" do
    field :name, :string
    field :slug, :string
    field :type, :integer

    timestamps()
  end

  @doc """
  category type acts as an enum, so check it is valid
  before saving
  """
  def validate_category_type(changeset, type_key) do
    type_value = get_field(changeset, type_key)
    if !Artour.CategoryType.is_valid(type_value) do
      add_error(changeset, type_key, "Invalid category type")
    end
    changeset
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :type])
    |> validate_required([:name, :slug, :type])
    |> validate_category_type(:type)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
