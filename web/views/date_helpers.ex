# For code shared across views that relates to whole application
defmodule Artour.DateHelpers do

	@doc """
  	Takes integer representing month
  	returns full English month-name
  	"""
	def to_month_name(month_number) do
		case month_number do
		  1 -> "January"
		  2 -> "February"
		  3 -> "March"
		  4 -> "April"
		  5 -> "May"
		  6 -> "June"
		  7 -> "July"
		  8 -> "August"
		  9 -> "September"
		  10 -> "October"
		  11 -> "November"
		  12 -> "December"
		end
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
  	Takes date string as argument
  	returns tuple of integers
  	{YYYY, MM, DD}
  	"""
	def date_to_tuple(date) do
		date
			|> Ecto.Date.cast! 
			|> Ecto.Date.dump
			|> elem(1)
	end

	@doc """
  	Takes datetime string as argument
  	returns string date in format `Month name DD, YYYY`
  	"""
	def datetime_to_display_date(datetime) do
		date_tuple = datetime_to_tuple(datetime)
		to_month_name(elem(date_tuple, 1)) <> 
		" " <>
		Integer.to_string(elem(date_tuple, 2)) <> 
		", " <>
		Integer.to_string(elem(date_tuple, 0))
	end

	@doc """
  	Takes datetime string as argument
  	returns string date in format MM-DD-YYYY
  	"""
	def datetime_to_us_date(datetime) do
		datetime |> datetime_to_tuple |> date_tuple_to_us_date
	end

	@doc """
  	Takes date string as argument
  	returns string date in format MM-DD-YYYY
  	"""
	def date_to_us_date(date) do
		date |> date_to_tuple |> date_tuple_to_us_date
	end

	@doc """
  	Takes date tuple in format {YYYY, MM, DD}
  	returns string date in format MM-DD-YYYY
  	"""
	def date_tuple_to_us_date(date_tuple) do
		Integer.to_string(elem(date_tuple, 1)) <> 
		"-" <>
		Integer.to_string(elem(date_tuple, 2)) <> 
		"-" <>
		Integer.to_string(elem(date_tuple, 0))
	end


end