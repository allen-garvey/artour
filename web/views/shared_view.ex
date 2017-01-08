defmodule Artour.SharedView do
	use Artour.Web, :view

	@doc """
  	On index pages, plural form might not necessarily be set,
  	so use assigns[:item_name_plural] as second argument
  	"""
	def pluralize_item_name(singular, plural) do
		if plural do
		  plural
		else
			singular <> "s"
		end
	end
end