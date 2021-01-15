defmodule Constance.MixProject do
  use Mix.Project

  def project do
    [
      app: :constance,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Constance.Application, []},
      extra_applications: [:logger, :runtime_tools, :sqlite_ecto2, :ecto]
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
     # {:slackex, "~> 0.0.1"},
      {:slack, "~> 0.23.5"},
      {:sqlite_ecto2, "~> 2.2"},
      {:sendgrid, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:httpoison, "~> 1.7"},
      {:phoenix, "~> 1.5.7"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end