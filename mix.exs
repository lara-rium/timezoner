defmodule Timezoner.MixProject do
  use Mix.Project

  def project do
    [
      app: :timezoner,
      version: "0.1.0",
      elixir: "~> 1.18",
      # credo:disable-for-next-line Credo.Check.Warning.MixEnv
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Timezoner.Main, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.0"},
      {:exsync, "~> 0.4", only: :dev},
      {:geocoder, "~> 2.2"},
      {:httpoison, "~> 2.2"},
      {:nostrum, "~> 0.10"},
      {:postgrex, ">= 0.0.0"},
      {:timex, "~> 3.0"},
      {:tz_world, "~> 1.3"}
    ]
  end
end
