# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :constance, ConstanceWeb.Endpoint,

  url: [host: "localhost"],
  secret_key_base: "7uWNjnyXEUsD/jnwTjSXyFdM0eow+EYIAdDsufhD/cEfxMW/aztK6fEGgHAE+m3E",
  render_errors: [view: LrucacheApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: LrucacheApi.PubSub,
  live_view: [signing_salt: "qKEM2UlV"]

config :sendgrid,
  api_key: "PUT YOUR SENDGRID KEY HERE"

config :constance, SqliteMonitor.Repo,
  adapter: Sqlite.Ecto2,
  database: "constance.sqlite3"

config :constance, ecto_repos: [SqliteMonitor.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
