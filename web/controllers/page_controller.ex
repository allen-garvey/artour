defmodule Artour.PageController do
  use Artour.Web, :controller
  alias Artour.Page

  def index(conn, %{"page_num" => page_num}) do
    last_page = Page.last_page Repo
    #no checking if page_num is valid or in range, because final product will be static site
    page_num = cond do
                  is_integer(page_num) -> page_num
                  true -> String.to_integer page_num
              end

    posts = Repo.all(Page.posts_for_page_query(page_num)) |> Repo.preload([:category, :cover_image])
    render conn, "index.html", posts: posts, current_page: page_num, last_page: last_page
  end

  @doc """
  Index defaults to first page
  """
  def index(conn, _params) do
    index conn, %{"page_num" => 1}
  end

  @doc """
  Shows about page
  """
  def about(conn, _params) do
    heading = "About " <> Artour.LayoutHelpers.site_title

    render conn, "basic_page.html", page_title: "About", heading: heading, body: Page.about_text
  end

  @doc """
  Shows list of categories that contain 1 or more related posts
  """
  def browse(conn, _params) do
  	
  	categories = Artour.Category.all_with_posts Repo
    tags = Artour.Tag.all_with_posts Repo 
    
    render conn, "browse.html", page_title: "Browse", categories: categories, tags: tags
  end

  @doc """
  Displays 404 page
  """
  def error_404(conn, _params) do
    render conn, "404.html", page_title: "404"
  end
end
