defmodule ConstanceWeb.MonitorController do
  use ConstanceWeb, :controller
  action_fallback ConstanceWeb.FallbackController
  def get_all(conn,_key_params) do
    results = GenServer.call(:monitor_gen_server,{:get_all}) 
    json conn |> put_status(:ok), results
  end

  def pause(conn, 
  %{
    "key" => key,
    "paused" => paused
  } = params) do 
    GenServer.cast(:monitor_gen_server,{:pause,key,paused})
    send_resp(conn, :no_content, "")
  end

  def update(conn, 
  %{
    "key" => key,
    "name" => name, 
    "url" => url,
  } = params) do 
    encoded = Poison.encode!(%Monitor.Http{uri: url})  
    GenServer.cast(:monitor_gen_server,{:update,key,name,encoded})
    send_resp(conn, :no_content, "")
  end

  def save(conn, 
  %{
    "name" => name, 
    "type" => type,
    "url" => url,
  } = params) do 
    encoded = Poison.encode!(%Monitor.Http{uri: url})  
    GenServer.cast(:monitor_gen_server,{:save,name,type,encoded})
    json conn |> put_status(:created), params
  end

  def delete(conn,%{"key" => key_params}) do
    GenServer.cast(:monitor_gen_server,{:delete,key_params})
    send_resp(conn, :no_content, "")
  end
end
