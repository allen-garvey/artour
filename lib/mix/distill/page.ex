defmodule Distill.Page do
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
end