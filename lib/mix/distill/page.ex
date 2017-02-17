defmodule Distill.Page do
	alias Distill.PageRoute
	@doc """
	Returns list of tuples in format: path (string), controller module(atom), controller handler function (atom), params (map)
	e.g. {"/posts", Artour.PostController, :index, %{}}
	"""
	def routes() do
		[
	  		%PageRoute{path: "/", controller: Artour.PageController, handler: :index},
	  		%PageRoute{path: "/404.html", controller: Artour.PageController, handler: :error_404},
	  		%PageRoute{path: "/about", controller: Artour.PageController, handler: :about},
	  		%PageRoute{path: "/browse", controller: Artour.PageController, handler: :browse},
	  		%PageRoute{path: "/posts", controller: Artour.PublicPostController, handler: :index},
	  		%PageRoute{path: "/categories", controller: Artour.PublicCategoryController, handler: :index},
	  		%PageRoute{path: "/tags", controller: Artour.PublicTagController, handler: :index},
		]
	end
end