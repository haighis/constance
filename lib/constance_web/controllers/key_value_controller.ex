defmodule ConstanceWeb.KeyValueController do
  use ConstanceWeb, :controller
#  import Cache.Server
  action_fallback ConstanceWeb.FallbackController

  def get(conn,%{"key" => key_params}) do
 #   val = GenServer.call(:mycache, {:get, key_params} )
 #   json conn |> put_status(:ok), val
  end

  def put(conn, %{"key" => key, "value" => value} = params) do 
  #  GenServer.cast(:mycache,{:put, key,value})
  #  json conn |> put_status(:created), params
  end
end
