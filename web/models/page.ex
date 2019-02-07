defmodule Artour.Page do
    import Ecto.Query

	@doc """
	Number of posts per page in index post list
	"""
	def posts_per_page() do
		4
	end

	@doc """
	Returns posts for current page
	page_num is 1 indexed page
	"""
	def posts_for_page_query(page_num) when is_integer(page_num) do
		post_offset = cond do
		  				page_num <= 0 -> 1
		  				true -> (page_num - 1) * posts_per_page()  
					end
		
		from(p in Artour.Post, where: p.is_published == true, order_by: [desc: :id], limit: ^posts_per_page(), offset: ^post_offset)
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
