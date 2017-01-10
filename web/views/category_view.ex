defmodule Artour.CategoryView do
  use Artour.Web, :view

  @doc """
  Renders page to create new category
  """
  def render("new.html", assigns) do
    render "new_edit_page.html", changeset: assigns[:changeset],
                        conn: assigns[:conn],
                        action: category_path(assigns[:conn], :create),
                        category_types: assigns[:category_types],
                        heading: "New category"
  end

  @doc """
  Renders page to edit category
  """
  def render("edit.html", assigns) do
    render "new_edit_page.html", changeset: assigns[:changeset],
                        conn: assigns[:conn],
                        action: category_path(assigns[:conn], :update, assigns[:category]),
                        category_types: assigns[:category_types],
                        heading: "Edit " <> Artour.Category.display_name(assigns[:category])
  end

  @doc """
  Used on index page - transforms category type integer into title-case
  string
  """
  def category_type_name(category_type_value) do
    Artour.CategoryType.name(category_type_value) |> String.capitalize
  end

  @doc """
  Used on index and show pages - returns list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names() do
    ["Name", "Slug", "Type"]
  end

  @doc """
  Used on index and show pages - takes category index and returns list of 
  formatted values
  """
  def attribute_values(category) do
  	[category.name, category.slug, category_type_name(category.type)]
  end

end
