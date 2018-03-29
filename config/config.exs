use Mix.Config

config :straw_hat_review, ecto_repos: [StrawHat.Review.Repo]

config :straw_hat_review, StrawHat.Review.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "straw_hat_review_test",
  username: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn
