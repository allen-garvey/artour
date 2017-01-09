defmodule Artour.CategoryView do
  use Artour.Web, :view

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
