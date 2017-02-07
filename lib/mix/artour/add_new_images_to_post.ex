#run task with 'mix artour.add_new_images_to_post'
defmodule Mix.Tasks.Artour.AddNewImagesToPost do
  use Mix.Task
  import Ecto.Query

  @doc """
  Adds new images to specified post
  args post_id, number of images to add(newest first)
  """
  def run([post_id, num_images]) do
    #start app so repo is available
    Mix.Task.run "app.start", []

    post = Artour.Repo.get!(Artour.Post, post_id) 
    images = newest_images(num_images)
    
    #add image to post's album
    for image <- images do
      changeset = Artour.PostImage.changeset(%Artour.PostImage{}, %{"post_id" => post.id, "image_id" => image.id})
      Artour.Repo.insert!(changeset)
      IO.puts Artour.ImageView.display_name(image) <> " added to " <> Artour.PostView.display_name(post)
    end
  end

  #retrieve images newest first, limited by max_images argument
  #as safety feature, limited to images created in last week
  def newest_images(max_images) do
    Artour.Repo.all(from(i in Artour.Image, where: i.inserted_at > type(^last_week_datetime, Ecto.DateTime), order_by: [desc: :id], limit: ^max_images))
  end

  #returns the datetime struct for 1 week ago
  def last_week_datetime() do
    now = DateTime.utc_now |> DateTime.to_unix
    week_in_seconds = 60 * 60 * 24 * 7
    Ecto.DateTime.from_unix!(now - week_in_seconds, :seconds)
  end

end