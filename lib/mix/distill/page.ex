defmodule Distill.Page do
	@doc """
	Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
	e.g. {"/posts", Artour.PostController, :index, %{}}
	"""
	def routes() do
		[
	  		{"/", Artour.PageController, :index},
	  		{"/404.html", Artour.PageController, :error_404},
	  		{"/about", Artour.PageController, :about},
	  		{"/browse", Artour.PageController, :browse},
	  		{"/posts", Artour.PublicPostController, :index},
	  		{"/categories", Artour.PublicCategoryController, :index},
	  		{"/tags", Artour.PublicTagController, :index},
		]
	end
end