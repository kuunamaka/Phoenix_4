# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_tutorial,
  ecto_repos: [TodoTutorial.Repo]

# Configures the endpoint
config :todo_tutorial, TodoTutorialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HAhv6JKfHrBrVp+WrW5Mdjj4SmAVln/wnnQUJmVNiAqibl8/Qm7SIpGT0mJDcNkr",
  render_errors: [view: TodoTutorialWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TodoTutorial.PubSub,
  live_view: [signing_salt: "jUfkXU7K"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
