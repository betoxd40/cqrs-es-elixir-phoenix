defmodule BankAPI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(BankAPI.Repo, []),
      supervisor(BankAPIWeb.Endpoint, []),
      supervisor(BankAPI.Accounts.Supervisor, []),
    ]

    opts = [strategy: :one_for_one, name: BankAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BankAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
