defmodule Artour.PageView do
  use Artour.Web, :view

  @doc """
  Transforms a list of posts in a page into a single string title
  using the dates of the last (oldest) and first (newest) posts on 
  the page
  """
  def page_summary_title(page_posts) when is_list(page_posts) do
  	oldest_post = List.last page_posts
  	newest_post = List.first page_posts
  	if oldest_post.id == newest_post.id do
  		datetime_to_display_date(Artour.Post.date_created(oldest_post))
  	else
  		datetime_to_display_date(Artour.Post.date_created(oldest_post)) <> " - " <> datetime_to_display_date(Artour.Post.date_created(newest_post))
  	end
  end
end
