defmodule Artour.ApiImageController do
  use Artour.Web, :controller

  alias Artour.Admin
  alias Artour.Image

  @doc """
  Creates image resources from given array
  """
  def create_many(conn, %{"images" => images}) do
    case create_images(images) do
      {:error, errors} -> render(conn, "errors.json", errors: errors)
      _                -> send_resp(conn, 200, "{\"data\": \"ok\"}")
    end
  end

  @doc """
  Creates images
  """
  def create_images(images) do
    Repo.transaction(fn ->
      {status, errors} = Enum.with_index(images)
      |> Enum.reduce({:ok, %{}}, fn {image, i}, {status, errors} ->
        case Admin.create_image(image) do
          {:ok, %Image{} = _image} -> {status, errors}
          {:error, changeset}      -> {:error, Map.put(errors, i, changeset)}
        end
      end)
      if status == :error do
        Repo.rollback(errors)
      end
    end)
  end
end
