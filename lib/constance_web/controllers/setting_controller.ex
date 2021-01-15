defmodule ConstanceWeb.SettingController do
  use ConstanceWeb, :controller
  action_fallback ConstanceWeb.FallbackController
  def get_all(conn,_key_params) do
    results = GenServer.call(:setting_gen_server,{:get_all}) 
    json conn |> put_status(:ok), results
  end
end
