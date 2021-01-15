defmodule Constance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
#
  use Application
  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      SqliteMonitor.Repo,
      # Settings GenServer - For managing Setting entries
      %{
        id: SettingServer,
        start: {Setting.Server, :start_link, [[name: :setting_gen_server]]}
      },
      # Monitor GenServer - For managing Monitor items
      %{
        id: MonitorServer,
        start: {Monitor.Server, :start_link, [[name: :monitor_gen_server]]}
      },
      # Monitor Schedule GenServer - Handles scheduling monitor items to be run every n time
      supervisor(MonitorScheduler, []),
      # Monitor Item Dynamic Supervisor
      %{
        id: MonitorItemSupervisor,
        start: {MonitorItemSupervisor, :start_link, [[]]}
      },
      # REST API 
      ConstanceWeb.Endpoint,    
    ]
    opts = [strategy: :one_for_one, name: Monitor.Supervisor]
    Supervisor.start_link(children, opts)
  end
  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ConstanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
