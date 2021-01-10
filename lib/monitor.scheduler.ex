# Monitor Scheduler will run every 15 minutes to get a list of monitor items
# and start child dynamic supervisors
defmodule MonitorScheduler do
  use GenServer
  
  @impl true
  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end
  
  @impl true
  def init(state) do
    schedule_work()
    {:ok, state}
  end
  
  @impl true
  def handle_info(:work, state) do
    do_recurring_task(state)
    schedule_work()
    {:noreply, state}
  end
  
  defp schedule_work do
    Process.send_after(self(), :work, 30_000)
  end
  
  defp do_recurring_task(state) do
    MonitorInitiator.get_monitor_items_to_check
  end
end