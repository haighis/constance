# Functional Core
# A Monitor libary that is developed as a functional core. 
# The functional core is library implementation.
# The functional core should work on data that’s validated and safe. It should be predictable, so it avoids side effects.
# A functional core is means to easily reason about the application core business logic that is the same pattern 
# created by James Edward Gray and Bruce A. Tate found in the book "Designing Elixir Systems with OTP". 
# 
# Design
# The Monitor uses 
# - Etso Ecto Adapter Repository pattern
# Usage
# Monitor.Core.get_all      
# SqliteMonitor.Repo.all(SqliteMonitor.Model.Item)   
# detail2 = Poison.encode!(%Monitor.Http{uri: "http://www.news.com"})  
# Monitor.Core.save("news.com","httpv1","5",detail2)      
# Monitor.Core.delete_by_id("52cd171c-70db-43bf-9763-a6160bd7baf4") 
# Monitor.Core.get_by_id("52cd171c-70db-43bf-9763-a6160bd7baf4") 
defmodule Monitor.Core do
    # Handle Put - Updates (or Inserts the value if it does not exist in the cache)
    def save(name, type, interval, details) do
        {result, monitor_item} = SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Item{name: name, type: type, interval: interval, details: details}) 
        IO.puts " #{inspect{monitor_item}}"
        result
    end

    def update(id, name, interval, details) do
        post = SqliteMonitor.Repo.get!(SqliteMonitor.Model.Item, id)
        post = Ecto.Changeset.change post, name: name, interval: interval, details: details
        case SqliteMonitor.Repo.update post do
        {:ok, struct}       -> IO.puts "i updated " # Updated with success
        {:error, changeset} -> # Something went wrong
        end
    end

    def get_by_id(id) do
        result = SqliteMonitor.Repo.get(SqliteMonitor.Model.Item,id)
        result    
    end

    def get_all() do
        items = SqliteMonitor.Repo.all(SqliteMonitor.Model.Item)
        # for x <- items do
        #     IO.inspect(x)
        #     IO.puts " item " <> x.name
        # end
        items
    end

    def delete_by_id(id) do
        post = SqliteMonitor.Repo.get!(SqliteMonitor.Model.Item,id)
        case SqliteMonitor.Repo.delete post do
        {:ok, struct}       -> :ok 
        {:error, changeset} -> # Something went wrong
        end
    end
end