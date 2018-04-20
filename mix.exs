defmodule StrawHat.Review.MixProject do
  use Mix.Project

  @name :straw_hat_review
  @version "0.0.0"
  @elixir_version "~> 1.6"

  @description """
  Review System
  """
  @source_url "https://github.com/straw-hat-team/straw_hat_review"

  def project do
    production? = Mix.env() == :prod

    [
      name: "StrawHat.Review",
      description: @description,
      app: @name,
      version: @version,
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases(),
      build_embedded: production?,
      start_permanent: production?,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test
      ],

      # Extras
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
      {:ecto, "~> 2.2"},
      {:scrivener_ecto, "~> 1.2"},
      {:arc, "~> 0.8.0"},
      {:arc_ecto, "~> 0.7.0"},
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

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
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
        Interactors: [],
        Schemas: []
      ]
    ]
  end
end
