defmodule Artour.ImageView do
  use Artour.Web, :view

  @doc """
  How single image instance should be represented in views
  """
  def display_name(image) do
    image.title
  end

  @doc """
  Renders page to create new image
  """
  def render("new.html", assigns) do
    assigns = Map.merge(assigns, %{action: image_path(assigns[:conn], :create),
                                   heading: Artour.SharedView.form_heading("image", :new)})

    render "form_page.html", assigns
  end

  @doc """
  Renders page to edit image
  """
  def render("edit.html", assigns) do
    assigns = Map.merge(assigns, %{action: image_path(assigns[:conn], :update, assigns[:image]),
                                   heading: Artour.SharedView.form_heading(display_name(assigns[:image]), :edit),
                                   show_delete: true})

    render "form_page.html", assigns
  end

  @doc """
  Returns cloud URL for image (i.e. for public site)
  size is atom representing image size
  While same as local url for now, in the future this might change to
  S3 or B2
  """
  def cloud_url_for(conn, image, size) do
    cloud_folder = "/media/images/"
    case size do
      :large -> static_path(conn, cloud_folder <> image.filename_large)
      :medium -> static_path(conn, cloud_folder <> image.filename_medium)
      :small -> static_path(conn, cloud_folder <> image.filename_small)
      :thumbnail -> static_path(conn, cloud_folder <> image.filename_thumbnail)      
    end
  end

  @doc """
  Returns local URL for image (i.e. for admin site)
  size is atom representing image size
  """
  def local_url_for(conn, image, size) do
    local_folder = "/media/images/"
    case size do
      :large -> static_path(conn, local_folder <> image.filename_large)
      :medium -> static_path(conn, local_folder <> image.filename_medium)
      :small -> static_path(conn, local_folder <> image.filename_small)
      :thumbnail -> static_path(conn, local_folder <> image.filename_thumbnail)      
    end
  end

  @doc """
  Used on index page - returns abbreviated list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names_short() do
    ["Title", "Description", "Format", "Date Completed"]
  end

  @doc """
  Used on index page - takes image instance and returns abbreviated list of 
  formatted values
  """
  def attribute_values_short(image) do
  	[image.title, image.description, Artour.FormatView.display_name(image.format), date_to_us_date(image.completion_date)]
  end

  @doc """
  Used on show page - returns list of attribute names in the
  same order as the attribute_values function
  """
  def attribute_names() do
    ["Title", "Description", "Filename Large", "Filename Medium", "Filename Small", "Filename Thumbnail", "Format", "Date Completed"]
  end

  @doc """
  Used on show page - takes image instance and returns list of 
  formatted values
  """
  def attribute_values(image) do
    [image.title, image.description, image.filename_large, image.filename_medium, image.filename_small, image.filename_thumbnail, Artour.FormatView.display_name(image.format), date_to_us_date(image.completion_date)]
  end
end
