use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :lucidboard, LucidboardWeb.Endpoint,
  http: [port: 8800],
  debug_errors: true,
  code_reloader: true,
  check_origin: false
  # watchers: [
  #   node: [
  #     "node_modules/webpack/bin/webpack.js",
  #     "--mode",
  #     "development",
  #     "--watch-stdin",
  #     cd: Path.expand("../assets", __DIR__)
  #   ]
  # ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :lucidboard, LucidboardWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/lucidboard_web/views/.*(ex)$},
      ~r{lib/lucidboard_web/templates/.*(eex)$},
      ~r{lib/lucidboard_web/controllers/.*(ex)$},
      ~r{lib/demo_web/live/.*(ex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :logger, truncate: :infinity

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

import_config "dev.secret.exs"
