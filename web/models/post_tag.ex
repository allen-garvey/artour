defmodule Artour.PostTag do
  use Artour.Web, :model

  schema "post_tags" do
    belongs_to :post, Artour.Post
    belongs_to :tag, Artour.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
    |> foreign_key_constraint(:post_id)
    |> foreign_key_constraint(:tag_id)
    |> assoc_constraint(:post) #validate existence
    |> assoc_constraint(:tag) #validate existence
    |> unique_constraint(:post_tag_unique_composite, name: :post_tag_unique_composite)
  end
end
