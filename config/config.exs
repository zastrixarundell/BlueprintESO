# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tailwind, version: "3.1.8", default: [
  args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
  cd: Path.expand("../assets", __DIR__)
]

config :blueprint_eso,
  namespace: BlueprintESO,
  ecto_repos: [BlueprintESO.Repo]

# Configures the endpoint
config :blueprint_eso, BlueprintESOWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlueprintESOWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BlueprintESO.PubSub,
  live_view: [signing_salt: "rZ3CNxXo"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    discord: {Ueberauth.Strategy.Discord, []}
  ]

config :ueberauth, Ueberauth.Strategy.Discord.OAuth,
  client_id: System.get_env("DISCORD_CLIENT_ID"),
  client_secret: System.get_env("DISCORD_CLIENT_SECRET")

config :blueprint_eso, BlueprintESOWeb.Authentication,
  issuer: "blueprint_eso",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
