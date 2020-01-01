defmodule LiveViewChatWeb.Router do
  use LiveViewChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewChatWeb do
    pipe_through :browser

    live "/", ChatLive.Chat
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewChatWeb do
  #   pipe_through :api
  # end
end
