defmodule ConstanceWeb.MonitorController do
  use ConstanceWeb, :controller
#  import Cache.Server
  action_fallback ConstanceWeb.FallbackController
  def get_all(conn,_key_params) do
    IO.puts "i am in get all"
    results = GenServer.call(:monitor_gen_server,{:get_all}) 
    json conn |> put_status(:ok), results
  end

  def get(conn,%{"key" => key_params}) do
 #   val = GenServer.call(:mycache, {:get, key_params} )
 #   json conn |> put_status(:ok), val
  end

  def update(conn, 
  %{
    "key" => key,
    "name" => name, 
    "interval" => interval,
    "url" => url,
  } = params) do 
    IO.inspect key
    encoded = Poison.encode!(%Monitor.Http{uri: url})  
    GenServer.cast(:monitor_gen_server,{:update,key,name,interval,encoded})
    #json conn |> put_status(:no_content), params
    send_resp(conn, :no_content, "")
  end

  def save(conn, 
  %{
    "name" => name, 
    "type" => type,
    "interval" => interval,
    "url" => url,
  } = params) do 
    encoded = Poison.encode!(%Monitor.Http{uri: url})  
    GenServer.cast(:monitor_gen_server,{:save,name,type,interval,encoded})
    json conn |> put_status(:created), params
  end

  def delete(conn,%{"key" => key_params}) do
    IO.inspect key_params
    GenServer.cast(:monitor_gen_server,{:delete,key_params})
    #json conn |> put_status(:ok), key_params
    send_resp(conn, :no_content, "")
  end
end
