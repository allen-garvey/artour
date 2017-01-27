#run task with 'mix artour.gen.html'
defmodule Mix.Tasks.Artour.Gen.Html do
  use Mix.Task
  import Plug.Test #for conn function

  @shortdoc "Generates static html files from pages and saves in given directory"
  def run(_args) do
    IO.puts "Generating HTML files" 
    #start app so repo is available
    Mix.Task.run "app.start", []
    
    #If want to do straight pipelines with no intermediate variables, must do
    # |> Map.fetch(:resp_body)
    # |> elem(1)
    conn = conn(:get, "/") 
      |> Plug.Conn.put_private(:phoenix_endpoint, Artour.Endpoint)
      |> Phoenix.Controller.put_new_layout({Artour.LayoutView, "public.html"})
      |> Phoenix.Controller.put_new_view(Artour.PostView)  
      # |> Artour.PostController.index(%{})
      #|> Map.fetch(:resp_body)
      #|> elem(1)
      #|> IO.puts
    #have to do this to dynamically call controller
    conn = apply(Artour.PostController, :index, [conn, %{}])
    IO.puts conn.resp_body
  end
end