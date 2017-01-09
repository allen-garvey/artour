defmodule Artour.SharedView do
	use Artour.Web, :view

	@doc """
  	Naive implementation of function to pluralize string
  	"""
	def naive_pluralize(singular) do
		if String.ends_with? singular, "y" do
		  String.replace_trailing(singular, "y", "ies")
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
  	Returns path to edit item
  	"""
	def item_edit_path(item_name_singular, conn, item) do
		apply(Artour.Router.Helpers, item_path_func_name(item_name_singular), [conn, :edit, item])
	end
	@doc """
  	Returns path to show item
  	"""
	def item_show_path(item_name_singular, conn, item) do
		apply(Artour.Router.Helpers, item_path_func_name(item_name_singular), [conn, :show, item])
	end
end