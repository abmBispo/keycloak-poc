defmodule KeyCloakPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      KeyCloakPoc.Repo,
      # Start the Telemetry supervisor
      KeyCloakPocWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KeyCloakPoc.PubSub},
      # Start the Endpoint (http/https)
      KeyCloakPocWeb.Endpoint,
      # Start a worker by calling: KeyCloakPoc.Worker.start_link(arg)
      {OpenIDConnect.Worker, Application.get_env(:key_cloak_poc, :openid_connect_providers)}
      # {KeyCloakPoc.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KeyCloakPoc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KeyCloakPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
