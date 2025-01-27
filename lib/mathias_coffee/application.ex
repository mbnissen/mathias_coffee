defmodule MathiasCoffee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :logger.add_handler(:my_sentry_handler, Sentry.LoggerHandler, %{
      config: %{metadata: [:file, :line]}
    })

    children = [
      MathiasCoffeeWeb.Telemetry,
      MathiasCoffee.Repo,
      {DNSCluster, query: Application.get_env(:mathias_coffee, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MathiasCoffee.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MathiasCoffee.Finch},
      # Start a worker by calling: MathiasCoffee.Worker.start_link(arg)
      # {MathiasCoffee.Worker, arg},
      # Start to serve requests, typically the last entry
      MathiasCoffeeWeb.Endpoint,
      {Cachex, [:my_cache, []]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MathiasCoffee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MathiasCoffeeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
