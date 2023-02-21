defmodule Momoir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MomoirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Momoir.PubSub},
      # Start the Endpoint (http/https)
      MomoirWeb.Endpoint
      # Start a worker by calling: Momoir.Worker.start_link(arg)
      # {Momoir.Worker, arg}
    ]

    # add cluster children (Mnesiac)
		children = case Momoir.Cluster.children_spec() do
			nil ->
				children

			children_spec ->
          children ++ children_spec
		end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Momoir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MomoirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
