defmodule Artour.ApiFormatController do
  use Artour.Web, :controller

  alias Artour.Format

  def index(conn, _params) do
    formats = Repo.all(Format.default_order_query())
    render(conn, "index.json", formats: formats)
  end

end
