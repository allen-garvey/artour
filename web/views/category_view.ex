defmodule Artour.CategoryView do
  use Artour.Web, :view

  @doc """
  Renders page to create new category
  """
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, %{action: category_path(assigns[:conn], :create),
                                   heading: Artour.SharedView.form_heading("category", :new)})

    render "form_page.html", assigns
  end

  @doc """
  Renders page to edit category
  """
  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, %{action: category_path(assigns[:conn], :update, assigns[:category]),
                                   heading: Artour.SharedView.form_heading(Artour.Category.display_name(assigns[:category]), :edit),
                                   show_delete: true})

    render "form_page.html", assigns
  end

  @doc """
  Renders page of list of related posts on public site
  """
  def render("show_public_post_list.html", assigns) do
    category = assigns[:category]

    render Artour.SharedView, "post_listing.html", conn: assigns[:conn], title: Artour.Category.display_name(category), posts: category.posts
  end

  @doc """
  Used to get the path for a category's public show page
  """
  def public_show_path(conn, category) do
    category_path(conn, :show_public, category.slug)
  end

  @doc """
  Used on index and show pages - transforms category type integer into title-case
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
  Used on index and show pages - takes category instance and returns list of 
  formatted values
  """
  def attribute_values(category) do
  	[category.name, category.slug, category_type_name(category.type)]
  end

end
