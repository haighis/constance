# Functional Core
# A Setting libary that is developed as a functional core. 
# The functional core is library implementation.
# The functional core should work on data that’s validated and safe. It should be predictable, so it avoids side effects.
# A functional core is means to easily reason about the application core business logic that is the same pattern 
# created by James Edward Gray and Bruce A. Tate found in the book "Designing Elixir Systems with OTP". 
# 
# Design
# The Setting uses 
# - Etso Ecto Adapter Repository pattern
# Usage
# Setting.Core.get_all      
# SqliteSetting.Repo.all(SqliteSetting.Model)   
# Setting.Core.save("mykey","myvalue")      
# Setting.Core.update(1,"mykey","mynewvalue")
# Setting.Core.delete_by_id(1) 
# Setting.Core.get_by_id(1) 
defmodule Setting.Core do
    import Ecto.Query, only: [from: 2]
    # Handle Put - Updates (or Inserts the value if it does not exist in the cache)
    def save(key, value) do
        {result, setting} = SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: key, value: value}) 
        result
    end

    def setup(scheduler_interval_seconds, 
        email_notifications_enabled, 
        slack_notifications_enabled, 
        all_notifications_enabled, 
        slack_apikey,
        sendgrid_apikey,
        email_to_address,
        email_from_address) do
        # Call functional core library to Save Settings
        delete_all
        save "scheduler_interval",scheduler_interval_seconds
        save "email_notifications_enabled",email_notifications_enabled
        save "slack_notifications_enabled",slack_notifications_enabled
        save "all_notifications_enabled",all_notifications_enabled
        save "slack_api_key",slack_apikey
        save "send_grid_key",sendgrid_apikey
        save "email_to_address",email_to_address
        save "email_from_address",email_from_address
    end

    def default_setup() do
        setup "5", "false", "false", "false", "", "", "", ""
    end

    def update(id, key, value) do
        setting = SqliteMonitor.Repo.get!(SqliteMonitor.Model.Setting, id)
        setting = Ecto.Changeset.change setting, key: key, value: value
        case SqliteMonitor.Repo.update setting do
        {:ok, struct}       -> IO.puts "i updated " # Updated with success
        {:error, changeset} -> # Something went wrong
        end
    end

    def get_by_id(id) do
        SqliteMonitor.Repo.get(SqliteMonitor.Model.Setting,id)
    end

    def get_by_key(key) do
        query = from s in SqliteMonitor.Model.Setting, where: s.key == type(^key, :string), select: s
        result = SqliteMonitor.Repo.all(query)
        if length(result) != 0 do
            [head | tail] = result
            head
        else 
            ""
        end
    end

    def get_all() do
        SqliteMonitor.Repo.all(SqliteMonitor.Model.Setting)
    end

    def delete_all() do
        qiuery = from(s in SqliteMonitor.Model.Setting, where: s.id > 0)
        SqliteMonitor.Repo.delete_all(qiuery)
    end

    def delete_by_id(id) do
        setting = SqliteMonitor.Repo.get!(SqliteMonitor.Model.Setting,id)
        case SqliteMonitor.Repo.delete setting do
        {:ok, struct}       -> :ok 
        {:error, changeset} -> # Something went wrong
        end
    end
end