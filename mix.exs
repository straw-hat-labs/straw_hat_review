defmodule StrawHat.Review.MixProject do
  use Mix.Project

  @name :straw_hat_review
  @version "0.2.0"
  @elixir_version "~> 1.6"
  @source_url "https://github.com/straw-hat-team/straw_hat_review"

  def project do
    production? = Mix.env() == :prod

    [
      name: "StrawHat.Review",
      description: "Review System",
      app: @name,
      version: @version,
      deps: deps(),
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: production?,
      start_permanent: production?,
      aliases: aliases(),
      test_coverage: test_coverage(),
      preferred_cli_env: preferred_cli_env(),
      dialyzer: dialyzer(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [
      mod: {StrawHat.Review.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:straw_hat, "~> 0.4"},
      {:postgrex, "~> 0.13"},
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:scrivener_ecto, "~> 2.0"},
      {:arc, "~> 0.11.0"},
      {:arc_ecto, "~> 0.11.1"},
      {:plug, "~> 1.5", optional: true},

      # Testing
      {:ex_machina, ">= 0.0.0", only: [:test]},
      {:faker, ">= 0.0.0", only: [:test]},

      # Tools
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:inch_ex, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp preferred_cli_env do
    [
      "ecto.reset": :test,
      "ecto.setup": :test,
      "coveralls.html": :test,
      "coveralls.json": :test
    ]
  end

  defp dialyzer do
    [
      plt_add_deps: :project,
      remove_defaults: [:unknown]
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test --trace"]
    ]
  end

  defp package do
    [
      name: @name,
      files: [
        "lib",
        "priv",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: [
        "Yordis Prieto",
        "Osley Zorrilla"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"],
      groups_for_modules: [
        "Use Cases": [
          StrawHat.Review.Reviews,
          StrawHat.Review.Aspects,
          StrawHat.Review.Medias,
          StrawHat.Review.Comments,
          StrawHat.Review.Reactions,
          StrawHat.Review.CommentReactions,
          StrawHat.Review.ReviewReactions
        ],
        Entities: [
          StrawHat.Review.Review,
          StrawHat.Review.Aspect,
          StrawHat.Review.Media,
          StrawHat.Review.Reaction,
          StrawHat.Review.Comment,
          StrawHat.Review.ReviewAspect,
          StrawHat.Review.ReviewReaction,
          StrawHat.Review.CommentReaction
        ],
        Arc: [
          StrawHat.Review.MediaFile,
          StrawHat.Review.MediaFile.Type
        ],
        Migrations: []
      ]
    ]
  end
end
