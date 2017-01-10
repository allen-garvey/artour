defmodule Artour.Category do
  use Artour.Web, :model
  import Artour.SlugValidator

  schema "categories" do
    field :name, :string
    field :slug, :string
    field :type, :integer

    timestamps()
  end

  @doc """
  How single category instance should be represented in views
  """
  def display_name(category) do
    category.name
  end

  @doc """
  category type acts as an enum, so check it is valid
  before saving
  """
  def validate_category_type(changeset, type_key) do
    type_value = get_field(changeset, type_key)
    if !Artour.CategoryType.is_valid(type_value) do
      add_error(changeset, type_key, "Invalid category type")
    else
      changeset
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :type])
    |> validate_required([:name, :slug, :type])
    |> validate_category_type(:type)
    |> validate_slug(:slug)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
