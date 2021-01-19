# Monitor Initiator is a helper library to start the Monitor Item Supervisor
defmodule MonitorInitiator do
  #  This function runs the query for to get all monitor items to start, iterates over the results 
  #  and tells the MonitorItemSupervisor to start a child process for each monitor item to check.
  #use Monitor.Core
  def get_monitor_items_to_check() do
    Monitor.Core.get_all
    |> Enum.map(&start_monitor_item(&1.name,Poison.decode!(&1.details, as: %Monitor.Http{}).uri ))
  end

  def start_monitor_item(monitor_name, url) do
    {:ok, pid} = MonitorItemSupervisor.start_work(monitor_name, url)
    pid
  end
end