#run task with 'mix distill.html'
defmodule Mix.Tasks.Distill.Html do
  use Mix.Task
  import Plug.Test, only: [conn: 2]

  @shortdoc "Generates static html files from pages and saves in given directory"
  def run(_args) do
    IO.puts "Generating HTML files"
    
    initialize_dest_directory()

    #start app so repo is available
    Mix.Task.run "app.start", []
    
    routes = page_routes() ++ post_routes()

    for page_route <- routes do
      conn = default_conn |> render_page_route(page_route)
      IO.puts conn.resp_body
    end
    
    
    #Path.join(dest_dir, "index.html") |> File.write!(conn.resp_body, [:utf8, :append])
  end

  @doc """
  Creates directory to store generated static site if it doesn't exisit
  """
  def initialize_dest_directory() do
    #directory where static files will be saved
    dest_dir = File.cwd! |> Path.join("_build") |> Path.join("static_site")
    #create dest dir if not exists
    File.mkdir_p! dest_dir
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

  @doc """
  Returns the filename to save a current path as
  """
  def filename_for(path) when is_binary(path) do
    Path.join(path, "index.html")
  end


  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def page_routes() do
    [
      {"/", Artour.PageController, :index, %{}}, 
      {"/browse", Artour.PageController, :browse, %{}}
    ]
  end

  @doc """
  Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
  e.g. {"/posts", Artour.PostController, :index, %{}}
  """
  def post_routes() do
    Artour.Repo.all(Artour.Post) |> Enum.map(&post_to_route/1)
  end

  @doc """
  Takes a post struct and returns route tuple
  """
  def post_to_route(post) do
    {"/posts/" <> post.slug, Artour.PublicPostController, :show, %{"slug" => post.slug}}
  end
end