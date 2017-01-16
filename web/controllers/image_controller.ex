defmodule Artour.ImageController do
  use Artour.Web, :controller

  alias Artour.Image

  def index(conn, _params) do
    images = Repo.all(from(Image, order_by: [desc: :id])) |> Repo.preload([:format])
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Image.changeset(%Image{})
    formats = Artour.Format.form_list(Repo)
    render(conn, "new.html", changeset: changeset, formats: formats)
  end

  def create(conn, %{"image" => image_params}) do
    changeset = Image.changeset(%Image{}, image_params)

    case Repo.insert(changeset) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: image_path(conn, :index))
      {:error, changeset} ->
        formats = Artour.Format.form_list(Repo)
        render(conn, "new.html", changeset: changeset, formats: formats)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Repo.get!(Image, id) |> Repo.preload([:format])
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)
    changeset = Image.changeset(image)
    formats = Artour.Format.form_list(Repo)
    render(conn, "edit.html", image: image, changeset: changeset, formats: formats)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Repo.get!(Image, id)
    changeset = Image.changeset(image, image_params)

    case Repo.update(changeset) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, changeset} ->
        formats = Artour.Format.form_list(Repo)
        render(conn, "edit.html", image: image, changeset: changeset, formats: formats)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: image_path(conn, :index))
  end
end
