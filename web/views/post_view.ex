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
  Used to get post admin show pages to highlight cover image
  """
  def is_cover_image(post, image) do
    post.cover_image_id === image.id
  end

  @doc """
  Used on index page - returns abbreviated list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names_short() do
    ["Title", "Slug", "NSFW", "Category", "Date Created"]
  end

  @doc """
  Used on index page - takes post instance and returns abbreviated list of 
  formatted values
  """
  def attribute_values_short(post) do
  	[post.title, post.slug, post.is_nsfw, Artour.CategoryView.display_name(post.category), datetime_to_us_date(Artour.Post.date_created(post))]
  end

  @doc """
  Used on show page - returns list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names() do
    ["Title", "Public Url", "Date Created", "Category", "NSFW", "Body"]
  end

  @doc """
  Used on show page - takes post instance and returns list of 
  formatted values
  """
  def attribute_values(conn, post) do
    [post.title, link(Artour.PublicPostView.show_path(conn, post), to: Artour.PublicPostView.show_path(conn, post)), datetime_to_us_date(Artour.Post.date_created(post)), Artour.CategoryView.display_name(post.category), post.is_nsfw, to_paragraphs(post.body)]
  end
end
