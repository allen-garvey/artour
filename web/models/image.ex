defmodule Artour.Image do
  use Artour.Web, :model

  schema "images" do
    field :title, :string
    field :description, :string
    field :filename_large, :string
    field :filename_medium, :string
    field :filename_small, :string
    field :filename_thumbnail, :string
    field :completion_date, Ecto.Date
    belongs_to :format, Artour.Format

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :filename_large, :filename_medium, :filename_small, :filename_thumbnail, :completion_date, :format_id])
    |> validate_required([:title, :description, :filename_large, :filename_medium, :filename_small, :filename_thumbnail, :completion_date, :format_id])
    |> foreign_key_constraint(:format_id)
    |> assoc_constraint(:format) #validate format exists
    |> unique_constraint(:title)
  end
end
