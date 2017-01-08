defmodule Artour.Router do
  use Artour.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # public site
  scope "/", Artour do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  #Admin site
  scope "/admin", Artour do
    pipe_through :browser # Use the default browser stack

    get "/", AdminController, :index

    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Artour do
  #   pipe_through :api
  # end
end
