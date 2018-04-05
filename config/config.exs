use Mix.Config

config :straw_hat_review, ecto_repos: [StrawHat.Review.Repo]

config :straw_hat_review, StrawHat.Review.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "straw_hat_review_test",
  username: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :straw_hat_review, StrawHat.Review, adapter: Swoosh.Adapters.Local

config :arc,
  storage: Arc.Storage.Local