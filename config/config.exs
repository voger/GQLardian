# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gqlardian,
  namespace: GQLardian,
  ecto_repos: [GQLardian.Repo]

# Configures Guardian
config :gqlardian, GQLardian.Auth.Guardian,
  issuer: "gqlardian",
  secret_key: "sPqPMlQ7BDIKuj/RE8YWd6fPwlXz3oftdlpgS7aPQTNOp5Je7iq3e3L9U6Odec3k",
  ttl: {1, :week}

# Configures the endpoint
config :gqlardian, GQLardianWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MzBlEZEzJAtzAlB/yOs4NFrwEXyeGorStZvA8zWax/gwzl1pW/A8T8bkHLo2IVaM",
  render_errors: [view: GQLardianWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GQLardian.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
