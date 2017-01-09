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
  Used on index page - takes category index and returns list of 
  formatted values
  """
  def index_row_values(category) do
  	[category.name, category.slug, category_type_name(category.type)]
  end
end
