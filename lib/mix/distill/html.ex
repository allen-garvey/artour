#run task with 'mix distill.html'
defmodule Mix.Tasks.Distill.Html do
  use Mix.Task
  import Plug.Test, only: [conn: 2]

  @shortdoc "Generates static html files from pages and saves in given directory"
  def run(_args) do
    dest_dir = default_dest_directory
    #create root directory if it doesn't exist
    File.mkdir_p! dest_dir

    IO.puts "Generating HTML files in " <> dest_dir

    #start app so repo is available
    Mix.Task.run "app.start", []
    
    routes = Distill.Page.routes
              ++ Distill.Post.routes
              ++ Distill.Tag.routes
              ++ Distill.Category.routes

    for page_route <- routes do
      #render the page
      conn = default_conn |> render_page_route(page_route)
      #make sure directory for file exists
      directory_name = dest_dir |> Path.join(elem(page_route, 0))
      File.mkdir_p! directory_name
      #save html to file
      filename = dest_dir |> Path.join(filename_for(page_route))
      save_to_file(conn, filename)
    end
    
  end

  @doc """
  Default directory to store generated static site
  """
  def default_dest_directory() do
    File.cwd! |> Path.join("_build") |> Path.join("distilled")
  end

  @doc """
  Saves html in conn response body to file specified by filename
  be aware that it overwrites the file if it exists
  """
  def save_to_file(%Plug.Conn{resp_body: resp_body}, filename) when is_binary(filename) do
    File.write!(filename, resp_body, [:utf8, :write])
  end

  @doc """
  Returns the filename to save a current path as
  """
  def filename_for({path, _controller, _handler, _params}) do
    filename_for path
  end

  @doc """
  Returns the filename to save a current path as
  """
  def filename_for(path) when is_binary(path) do
    Path.join(path, "index.html")
  end


  @doc """
  Returns base conn struct
  have to initialize with Phoenix.Controller.put_new_view before
  Phoenix.Controller.render will work
  """
  def default_conn() do
    conn(:get, "/") 
      |> Plug.Conn.put_private(:phoenix_endpoint, Artour.Endpoint)
      |> Phoenix.Controller.put_new_layout({Artour.LayoutView, "public.html"})
  end

  @doc """
  Returns conn after rendering page route
  second argument should be list item from page_routes function
  conn.resp_body will contain rendered page
  """
  def render_page_route(conn, {_path, controller, handler, params}) do
    #can't use pipes if we want to dynamically call controller
    conn = Phoenix.Controller.put_new_view(conn, default_view_for(controller))
    apply(controller, handler, [conn, params])
  end

  @doc """
  Returns default module name atom for a given controller
  (the same as controller name with controller replaced by view)
  """
  def default_view_for(controller) when is_atom(controller) do
    controller 
      |> Atom.to_string 
      |> String.replace_suffix("Controller", "View") 
      |> String.to_atom
  end

end