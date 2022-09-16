defmodule BlueprintESOWeb.Router do
  use BlueprintESOWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BlueprintESOWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :guardian do
    plug BlueprintESOWeb.Authentication.Pipeline
  end

  scope "/character", BlueprintESOWeb do
    pipe_through [:guardian, :browser]

    get "/new", CharacterController, :new
    patch "/reset/:id", CharacterController, :reset
    post "/cooldown/:id", CharacterController, :cooldown
    delete "/:id", CharacterController, :delete
  end

  scope "/auth", BlueprintESOWeb do
    pipe_through :browser

    get "/discord", Auth.DiscordController, :request
    get "/discord/callback", Auth.DiscordController, :callback

    scope "/" do
      pipe_through :guardian
      delete "/logout", Auth.DiscordController, :logout
    end

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlueprintESOWeb do
    pipe_through [:browser, :guardian]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlueprintESOWeb do
  #   pipe_through :api
  # end
end
