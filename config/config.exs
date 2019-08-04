use Mix.Config

config :straw_hat_review, ecto_repos: [StrawHat.Review.Repo]

config :straw_hat_review, StrawHat.Review.Repo,
  database: "straw_hat_review_test",
  username: "postgres",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

config :arc, storage: Arc.Storage.Local

config :logger, level: :warn
