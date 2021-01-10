defmodule MonitorItemSupervisor do
  use DynamicSupervisor
  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_work(monitor_name, url) do
    spec = %{id: MonitorItemWorker, start: {MonitorItemWorker, :start_link, [[monitor_name, url]]}, restart: :temporary}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end