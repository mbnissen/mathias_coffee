import Config

# Print only warnings and errors during test
config :logger, level: :warning

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used

# In test we don't send emails
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :mathias_coffee, MathiasCoffee.Mailer, adapter: Swoosh.Adapters.Test

config :mathias_coffee, MathiasCoffee.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "mathias_coffee_test#{System.get_env("MIX_TEST_PARTITION")}",
  # We don't run a server during test. If one is required,
  # you can enable the server option below.
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :mathias_coffee, MathiasCoffeeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YHakSF/a2unO79rsnKAZP0gORaKp4lesNQhJ+eCvGVoykC9Mk/KviR8SrEZvzaQX",
  server: false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false
