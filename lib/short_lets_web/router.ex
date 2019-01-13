defmodule ShortLetsWeb.Router do
  use ShortLetsWeb, :router

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

  scope "/", ShortLetsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/apartments", ApartmentController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShortLetsWeb do
  #   pipe_through :api
  # end
end
