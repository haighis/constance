defmodule Constance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      supervisor(SqliteMonitor.Repo, []),
      supervisor(MonitorScheduler, []),
      %{
        id: MonitorItemSupervisor,
        start: {MonitorItemSupervisor, :start_link, [[]]}
      }    
    ]
    opts = [strategy: :one_for_one, name: Curriculum.Supervisor]
    Supervisor.start_link(children, opts)
  end
  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ConstanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
