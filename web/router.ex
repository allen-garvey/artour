defmodule Artour.Router do
  use Artour.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  #no need for CSRF protection, sessions or flash
  #since we are just viewing pages
  pipeline :public_browser do
    plug :accepts, ["html"]
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
    pipe_through [:public_browser, :public_layout]

    get "/", PageController, :index
    get "/browse", PageController, :browse

    #show individual category by slug
    get "/categories/:slug", PublicCategoryController, :show
    #list of all posts
    get "/posts", PublicPostController, :index
    #show individual post by slug
    get "/posts/:slug", PublicPostController, :show
  end

  #Admin site
  scope "/admin", Artour do
    pipe_through :browser

    get "/", AdminController, :index

    resources "/categories", CategoryController
    resources "/posts", PostController
    resources "/formats", FormatController
    resources "/images", ImageController
    resources "/post_images", PostImageController
    resources "/tags", TagController
    resources "/post_tags", PostTagController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Artour do
  #   pipe_through :api
  # end
end
