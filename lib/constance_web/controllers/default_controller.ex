defmodule ConstanceWeb.DefaultController do
  use ConstanceWeb, :controller

  def index(conn, _params) do
    text conn, "Welcome to Constance. Personal desktop Network Monitor."
  end
end