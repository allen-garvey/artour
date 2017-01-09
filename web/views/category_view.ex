defmodule Artour.CategoryView do
  use Artour.Web, :view

  def category_type_name(category_type_value) do
    Artour.CategoryType.name(category_type_value) |> String.capitalize
  end

  def index_row_values(category) do
  	[category.name, category.slug, category_type_name(category.type)]
  end
end
