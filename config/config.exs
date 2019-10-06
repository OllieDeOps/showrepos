# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :showrepos, ShowreposWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I6W1LnHKB6nZzhO+SknGJFChzCxgEcHfLM76iJQKkYdFPxv1eVftxSYo91gEC9oR",
  render_errors: [view: ShowreposWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Showrepos.PubSub, adapter: Phoenix.PubSub.PG2],
  github_access_token: System.get_env("GITHUB_ACCESS_TOKEN")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
