import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :momoir, MomoirWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nuTJ9wdRDx6QqwU6z/0ODsw4X+cdKaKeCw3Kv/Ksz1fAH03WdHyr0OgD/XPOddL3",
  server: false

# In test we don't send emails.
config :momoir, Momoir.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
