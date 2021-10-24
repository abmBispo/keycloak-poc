import Config

# Configure your database
config :key_cloak_poc, KeyCloakPoc.Repo,
  username: "postgres",
  password: "postgres",
  database: "key_cloak_poc_dev",
  hostname: "db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :key_cloak_poc, KeyCloakPocWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "trGbTgDFTR3IECF8cdlmpW9LWavf+H8xQeDT1CLMX/Dv5gAhQh5E+8GeGKBvan55",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :key_cloak_poc, :openid_connect_providers,
  phoenix: [
    discovery_document_uri: "http://localhost:8080/.well-known/openid-configuration",
    client_id: "CLIENT_ID",
    client_secret: "CLIENT_SECRET",
    redirect_uri: "https://example.com/session",
    response_type: "code",
    scope: "openid email profile"
  ]

