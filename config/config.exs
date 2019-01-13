# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :short_lets,
  ecto_repos: [ShortLets.Repo]

# Configures the endpoint
config :short_lets, ShortLetsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qQWMHLUsfXxE8elPwkxKEaFQICBZL7EDUdfOcdlGN+yMmj2A6l3U1hvU63oAEWY9",
  render_errors: [view: ShortLetsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShortLets.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure :ex_aws
config :ex_aws,
  access_key_id: "ACCESS_KEY",
  secret_access_key: "ACCESS_SECRET",
  s3: [
    scheme: "https://",
    host: "YOUR-BUCKET.s3.amazonaws.com",
    region: "eu-west-2" 
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
