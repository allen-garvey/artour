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

	@doc """
  	Used to generate name for path helper function
  	"""
	def item_path_func_name(item_name_singular) do
		String.to_atom(item_name_singular <> "_path")
	end

	@doc """
  	Returns path for new item
  	"""
	def item_new_path(item_name_singular, conn) do
		apply(Artour.Router.Helpers, item_path_func_name(item_name_singular), [conn, :new])
	end

	@doc """
  	Returns path for edit item
  	"""
	def item_edit_path(item_name_singular, conn, item) do
		apply(Artour.Router.Helpers, item_path_func_name(item_name_singular), [conn, :edit, item])
	end
end