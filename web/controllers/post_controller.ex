defmodule Artour.PostController do
  use Artour.Web, :controller

  alias Artour.Post

  def index(conn, _params) do
    posts = Repo.all(Post.default_order_query()) |> Repo.preload([:category])
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
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
    post = Repo.get!(Post, id) |> Repo.preload([:category])
    post_images = Repo.all(from(pi in Artour.PostImage, where: pi.post_id == ^post.id, order_by: [pi.order, pi.id])) |> Repo.preload([:image])
    render(conn, "show.html", post: post, post_images: post_images)
  end

  @doc """
  Used on public site to show individual post
  """
  def show_public(conn, %{"slug" => slug}) do
    post = Repo.get_by!(Post, slug: slug) |> Repo.preload([:category])
    render(conn, "show_public_album.html", post: post)
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
end
