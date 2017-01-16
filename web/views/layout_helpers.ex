# For code shared across views that relates to whole application
defmodule Artour.LayoutHelpers do
	use Phoenix.HTML

	@doc """
  	Used in title of site, in such places as the title tag
  	"""
	def site_title() do
		"Strange Scenery"	
	end

	@doc """
  	Takes string and splits by newlines, converts into
  	paragraph tags and returns string of combined paragraphs
  	"""
  	def to_paragraphs(text) do
  		cond do
  			#is_binary tests if string
  			is_binary(text) -> to_paragraphs_safe text
  			true -> raw ""
  		end
  	end

  	@doc """
  	Same as to paragraphs, but text should be checked first that 
  	argument is string and not nil
  	"""
  	def to_paragraphs_safe(text) do
  		text
  			|> String.split("\n")
  			# remove empty strings to allow multiple line-breaks in raw text
  			|> Enum.filter(&(String.length(&1) > 1))
  			|> Enum.map(&(content_tag(:p, &1)))
  			|> Enum.map(&safe_to_string/1)
  			|> Enum.join
  			|> raw
  	end

end