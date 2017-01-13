defmodule Artour.PostView do
  use Artour.Web, :view

  @doc """
  Renders page to create new post
  """
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, %{action: post_path(assigns[:conn], :create),
                                   heading: Artour.SharedView.form_heading("post", :new)})

    render "form_page.html", assigns
  end

  @doc """
  Renders page to edit post
  """
  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, %{action: post_path(assigns[:conn], :update, assigns[:post]),
                                   heading: Artour.SharedView.form_heading(Artour.Post.display_name(assigns[:post]), :edit),
                                   show_delete: true})

    render "form_page.html", assigns
  end

  @doc """
  Used on index page - returns abbreviated list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names_short() do
    ["Title", "Slug", "Category"]
  end

  @doc """
  Used on index page - takes post instance and returns abbreviated list of 
  formatted values
  """
  def attribute_values_short(post) do
  	[post.title, post.slug, Artour.Category.display_name(post.category)]
  end

  @doc """
  Used on show page - returns list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names() do
    ["Title", "Slug", "Category", "Body"]
  end

  @doc """
  Used on show page - takes post instance and returns list of 
  formatted values
  """
  def attribute_values(post) do
    [post.title, post.slug, Artour.Category.display_name(post.category), post.body]
  end
end
