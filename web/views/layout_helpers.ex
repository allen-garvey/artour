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
  	Takes datetime string as argument
  	returns tuple of integers
  	{YYYY, MM, DD}
  	"""
	def datetime_to_tuple(datetime) do
		datetime
			|> Ecto.DateTime.cast! 
			|> Ecto.DateTime.to_date
			|> Ecto.Date.dump
			|> elem(1)
	end

	@doc """
  	Takes datetime string as argument
  	returns string date in format MM-DD-YYYY
  	"""
	def datetime_to_us_date(datetime) do
		date_tuple = datetime_to_tuple(datetime)
		Integer.to_string(elem(date_tuple, 1)) <> 
		"-" <>
		Integer.to_string(elem(date_tuple, 2)) <> 
		"-" <>
		Integer.to_string(elem(date_tuple, 0))
	end

	@doc """
  	Takes string and splits by newlines, converts into
  	paragraph tags and returns string of combined paragraphs
  	"""
  	def to_paragraphs(text) do
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