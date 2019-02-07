defmodule Artour.Page do
    import Ecto.Query

	@doc """
	Number of posts per page in index post list
	"""
	def posts_per_page() do
		4
	end

	@doc """
	Returns last page number (1 indexed)
	"""
	def last_page(repo) do
		post_count = repo.one!(from p in Artour.Post, where: p.is_published, select: count(p.id))
		(1.0 * post_count / posts_per_page())
			|> Float.ceil
			|> round
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
