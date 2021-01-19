defmodule MonitorItemWorker do
  use GenServer

  def start_link([name, url]) do
    GenServer.start_link(__MODULE__, [name, url])
  end

  def init([name, url]) do
    send(self(), :check_item)
    {:ok,
      %{
        name: name, url: url
      }
    }
  end

  def handle_info(:check_item, state) do
    # Call functional core to do a Http Check for url
    # If success then send a message of success
    # If fail then send a message of failure
    case Http.Check.Core.process_by_url(state.url) do
      :ok ->
          GenServer.cast(self(), {:success})
      :error ->
          GenServer.cast(self(), {:failure})
          #IO.puts "we did not succeed"
    end
    {:noreply, state}
  end

  def handle_cast({:success}, state) do
    #IO.puts "in am in sucess message" <> state.name
    # TODO store a success entry in status success history table
    #Notify.Core.send_notification state.name, "up"
    {:stop, :done, state}
  end

  def handle_cast({:failure}, state) do
    # TODO store a failure entry in status failure history table
    #IO.puts "in am in failure message" <> state.name
    Notify.Core.send_notification state.name, "down"
    {:stop, :done, state}
  end

  def terminate(reason, state) do
      :ok
  end
end