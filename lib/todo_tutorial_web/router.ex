defmodule TodoTutorialWeb.Router do
  use TodoTutorialWeb, :router
  alias Task.FavoriteController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", TodoTutorialWeb do
    pipe_through :browser
    get "/", PageController, :index

    resources "/users", UserController

    resources "/tasks", TaskController
  end

  scope "/api", TodoTutorialWeb, as: :api do
    pipe_through :api

    resources "/tasks", Api.TaskController do
      resources "/users", Api.FavoriteController, only: [:create, :delete]
      resources "/comments", Api.CommentController, only: [:create, :delete, :index]
    end
    resources "/users", Api.UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoTutorialWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TodoTutorialWeb.Telemetry
    end
  end
end
