# Functional Core
# A Monitor libary that is developed as a functional core. 
# Calling process_by_url with a string Url will return an atom :ok for success or :error
# 
# Design
# The Monitor uses HTTPoison
# - Etso Ecto Adapter Repository pattern
# Usage
# Http.Check.Core.process_by_url "http://www.test.com" 
defmodule Http.Check.Core do
    def process_by_url(url) do
        case HTTPoison.get(url) do
        {:ok, %HTTPoison.Response{status_code: 301, body: body}} ->
            #IO.puts body
            :ok
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            #IO.puts body
            :ok
        {:ok, %HTTPoison.Response{status_code: 404}} ->
            #IO.puts "Not found :("
            :error
        {:error, %HTTPoison.Error{reason: reason}} ->
            #IO.inspect reason
            :error
        end
    end
end