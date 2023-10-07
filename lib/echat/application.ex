defmodule Echat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EchatWeb.Telemetry,
      # Start the Ecto repository
      Echat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Echat.PubSub},
      # Start Finch
      {Finch, name: Echat.Finch},
      # Start the Endpoint (http/https)
      EchatWeb.Endpoint
      # Start a worker by calling: Echat.Worker.start_link(arg)
      # {Echat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Echat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EchatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
