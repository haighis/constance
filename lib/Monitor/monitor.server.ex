# Boundary Layer
# Server boundary layer is a GenServer that has state and allows message passing using OTP GenServer. 
# The boundary layer is a user friendly API that a developer can consume in their application.
#
# Usage
defmodule Monitor.Server do
    use GenServer
    # Import Functional core libary that has our Lrucache Business Logic
    alias Monitor.Core
    # Client API
    def start_link(opts) do
        name = opts[:name]
        GenServer.start_link(__MODULE__, [], name: name)
    end

    def start_link() do
        GenServer.start_link(__MODULE__, [])
    end

    def init(init_arg) do
      {:ok, init_arg}
    end

    def state(pid) do
        GenServer.call(pid, :state)
    end

    # Server (callbacks)
    def handle_call({:get_all}, _from, state) do
        # Call functional core library
        results = Core.get_all
        {:reply, results, state}
    end

    def handle_cast({:update, key, name, interval, details}, state) do
        # Call functional core library
        Core.update(key, name, interval, details)
        {:noreply, state}
    end

    def handle_cast({:save, name, type, interval, details}, state) do
        # Call functional core library
        Core.save(name, type, interval, details)
        {:noreply, state}
    end

    def handle_cast({:delete, key}, state) do
        # Call functional core library
        Core.delete_by_id(key)
        {:noreply, state}
    end

    def terminate(_reason, state) do
        :ok
    end
end