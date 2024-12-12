defmodule Chereta.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CheretaWeb.Telemetry,
      Chereta.Repo,
      {DNSCluster, query: Application.get_env(:chereta, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Chereta.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Chereta.Finch},
      # Start a worker by calling: Chereta.Worker.start_link(arg)
      # {Chereta.Worker, arg},
      # Start to serve requests, typically the last entry
      CheretaWeb.Endpoint,
      CheretaWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chereta.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CheretaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
