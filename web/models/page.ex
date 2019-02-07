defmodule Artour.Page do
    import Ecto.Query

	@doc """
	Number of posts per page in index post list
	"""
	def posts_per_page() do
		4
	end
  
	@doc """
	Body text for about page
	"""
	def about_text() do
		"""
		A collection of some of my sketches, drawings, photographs and digital artwork.
		"""
	end
end
