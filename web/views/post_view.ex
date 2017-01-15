defmodule Artour.PostView do
  use Artour.Web, :view

  @doc """
  How single post instance should be represented in views
  """
  def display_name(post) do
    post.title
  end

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
                                   heading: Artour.SharedView.form_heading(display_name(assigns[:post]), :edit),
                                   show_delete: true})

    render "form_page.html", assigns
  end

  @doc """
  Used to get the path for a post's public show page
  """
  def public_show_path(conn, post) do
    post_path(conn, :show_public, post.slug)
  end

  @doc """
  Used on index page - returns abbreviated list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names_short() do
    ["Title", "Slug", "Category", "Date Created"]
  end

  @doc """
  Used on index page - takes post instance and returns abbreviated list of 
  formatted values
  """
  def attribute_values_short(post) do
  	[post.title, post.slug, Artour.CategoryView.display_name(post.category), datetime_to_us_date(Artour.Post.date_created(post))]
  end

  @doc """
  Used on show page - returns list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names() do
    ["Title", "Slug", "Date Created", "Category", "Body"]
  end

  @doc """
  Used on show page - takes post instance and returns list of 
  formatted values
  """
  def attribute_values(post) do
    [post.title, post.slug, datetime_to_us_date(Artour.Post.date_created(post)), Artour.CategoryView.display_name(post.category), to_paragraphs(post.body)]
  end
end
