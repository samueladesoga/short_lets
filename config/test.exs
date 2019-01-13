use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :short_lets, ShortLetsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :short_lets, ShortLets.Repo,
  username: "postgres",
  password: "postgres",
  database: "short_lets_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
