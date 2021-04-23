defmodule ClusterEcs.MixProject do
  use Mix.Project

  def project do
    [
      app: :libcluster_ecs,
      version: "0.6.0",
      elixir: "~> 1.10",
      name: "libcluster_ecs",
      source_url: "https://github.com/pro-football-focus/libcluster_ecs",
      homepage_url: "https://github.com/pro-football-focus/libcluster_ecs",
      description: description(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 2.0 or ~> 3.0"},
      {:ex_aws, "~> 2.2.1"},
      {:configparser_ex, "~> 4.0"},
      {:hackney, "~> 1.9"},
      {:jason, ">= 1.1.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    ECS clustering strategy for libcluster
    """
  end


  def package do
    [
      maintainers: ["Geoff Lane"],
      licenses: ["MIT License"],
      links: %{
        "GitHub" => "https://github.com/pro-football-focus/libcluster_ecs.git"
      }
    ]
  end
end
