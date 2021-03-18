defmodule Constance.MixProject do
  use Mix.Project

    @app :constance

  def project do
    [
      app: @app,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_env: [release: :prod]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Constance.Application, []},
      extra_applications: [:logger, :runtime_tools, :ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:slack, "~> 0.23.5"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:sendgrid, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:httpoison, "~> 1.7"},
      {:phoenix, "~> 1.5.7"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:bakeware, "~> 0.1.4"}
    ]
  end

  defp aliases do
    [
      assets: ["cmd npm run deploy --prefix assets"],
      release: ["assets", "phx.digest", "release"],
      setup: ["deps.get", "cmd npm install --prefix assets"]
    ]
  end

  defp release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      quiet: true,
      steps: [:assemble, &Bakeware.assemble/1],
      strip_beams: Mix.env() == :prod
    ]
  end
end
