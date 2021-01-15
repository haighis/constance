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
        email_notifications_enabled, 
        slack_notifications_enabled, 
        all_notifications_enabled, 
        slack_apikey,
        sendgrid_apikey,
        email_to_address,
        email_from_address
        }, state) do
        # Call functional core library to Save Settings
        Core.delete_all
        Core.save("email_notifications_enabled",email_notifications_enabled)
        Core.save("slack_notifications_enabled",slack_notifications_enabled)
        Core.save("all_notifications_enabled",all_notifications_enabled)
        Core.save("slack_api_key",slack_apikey)
        Core.save("send_grid_key",sendgrid_apikey)
        Core.save("email_to_address",email_to_address)
        Core.save("email_from_address",email_from_address)
        {:noreply, state}
    end

    def terminate(_reason, state) do
        :ok
    end
end