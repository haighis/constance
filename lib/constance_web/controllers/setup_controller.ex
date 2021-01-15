defmodule ConstanceWeb.SetupController do
  use ConstanceWeb, :controller
  action_fallback ConstanceWeb.FallbackController
  def setup(conn, 
  %{
    "slack_apikey" => slack_apikey, 
    "sendgrid_apikey" => sendgrid_apikey,
    "email_notifications_enabled" => email_notifications_enabled,
    "slack_notifications_enabled" => slack_notifications_enabled,
    "notifications_enabled" => notifications_enabled,
    "email_from_address" => email_from_address,
    "email_to_address" => email_to_address
  } = params) do 
    GenServer.cast(:setting_gen_server,{:setup,
    email_notifications_enabled,
    slack_notifications_enabled,
    notifications_enabled,
    slack_apikey,
    sendgrid_apikey,
    email_to_address,
    email_from_address})
    json conn |> put_status(:created), params
  end
end