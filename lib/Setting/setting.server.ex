# Boundary Layer
# Server boundary layer is a GenServer that has state and allows message passing using OTP GenServer. 
# The boundary layer is a user friendly API that a developer can consume in their application.
#
# Usage
defmodule Setting.Server do
    use GenServer
    # Import Functional core libary that has our Lrucache Business Logic
    alias Setting.Core
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

    def handle_cast({:setup, 
        scheduler_interval_seconds,
        email_notifications_enabled, 
        slack_notifications_enabled, 
        all_notifications_enabled, 
        slack_apikey,
        sendgrid_apikey,
        email_to_address,
        email_from_address
        }, state) do
        
        Core.setup scheduler_interval_seconds,
        email_notifications_enabled, 
        slack_notifications_enabled, 
        all_notifications_enabled, 
        slack_apikey,
        sendgrid_apikey,
        email_to_address,
        email_from_address
        {:noreply, state}
    end

    def terminate(_reason, state) do
        :ok
    end
end