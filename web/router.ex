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

  # based on:
  # http://www.cultivatehq.com/posts/how-to-set-different-layouts-in-phoenix/
  pipeline :public_layout do
    plug :put_layout, {Artour.LayoutView, :public}
  end

  # public site
  scope "/", Artour do
    pipe_through [:browser, :public_layout] # Use the default browser stack

    get "/", PageController, :index
    get "/browse", PageController, :browse

    #show individual category by slug
    get "/categories/:slug", CategoryController, :show_public
    #show individual post by slug
    get "/posts/:slug", PublicPostController, :show
  end

  #Admin site
  scope "/admin", Artour do
    pipe_through :browser # Use the default browser stack

    get "/", AdminController, :index

    resources "/categories", CategoryController
    resources "/posts", PostController
    resources "/formats", FormatController
    resources "/images", ImageController
    resources "/post_images", PostImageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Artour do
  #   pipe_through :api
  # end
end
