defmodule Artour.PostController do
  use Artour.Web, :controller

  alias Artour.Admin
  alias Artour.Post

  def index(conn, _params) do
    posts = Repo.all(Post.default_order_query()) |> Repo.preload([:category])
    view = view_module(conn)
    put_view(conn, Artour.SharedView) |>
      render("index.html", items: posts, item_name_singular: "post", column_headings: view.attribute_names_short(), item_view: view,
                                row_values_func_name: :attribute_values_short)
  end

  def new(conn, _params) do
    #set new posts to use last added image by default
    default_cover_image_id = Repo.one!(from i in Artour.Image, select: i.id, order_by: [desc: :id], limit: 1)
    changeset = Post.changeset(%Post{cover_image_id: default_cover_image_id})
    categories = Artour.Category.form_list(Repo)
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        categories = Artour.Category.form_list(Repo)
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Admin.get_post_for_show!(id)

    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    categories = Artour.Category.form_list(Repo)
    render(conn, "edit.html", post: post, changeset: changeset, categories: categories)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        categories = Artour.Category.form_list(Repo)
        render(conn, "edit.html", post: post, changeset: changeset, categories: categories)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  @doc """
  Displays form with images not used in any albums
  """
  def add_images(conn, %{"post" => post_id, "unused" => _unused}) do
    image_ids_used = Repo.all(from(pi in Artour.PostImage, select: pi.image_id))

    add_images_page(conn, post_id, image_ids_used, false)
  end

  @doc """
  Displays form with images not used in post album
  that can be added
  """
  def add_images(conn, %{"post" => post_id}) do
    image_ids_used = Repo.all(from(pi in Artour.PostImage, select: pi.image_id, where: pi.post_id == ^post_id))

    add_images_page(conn, post_id, image_ids_used, true)
  end

  defp add_images_page(conn, post_id, image_ids_used, all_images_shown) do
    post = Repo.get!(Post, post_id)
    unused_images = Repo.all(from(i in Artour.Image, where: not(i.id in ^image_ids_used), order_by: [desc: i.id]))
    
    render conn, "add_images.html", post: post, images: unused_images, all_images_shown: all_images_shown
  end

  @doc """
  Saves images added from add_images form
  images should be array of image_ids
  """
  def save_images(conn, %{"post" => post_id, "images" => images}) do
    post = Repo.get!(Post, post_id)
    
    #add images to post
    #reverse order so images are ordered oldest to newest
    for image_id <- Enum.reverse(images) do
      changeset = Artour.PostImage.changeset(%Artour.PostImage{}, %{"post_id" => post.id, "image_id" => image_id})
      Repo.insert!(changeset)
    end
    
    conn
        |> put_flash(:info, "Images added")
        |> redirect(to: post_path(conn, :show, post))
  end


end
