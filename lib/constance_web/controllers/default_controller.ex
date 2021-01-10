defmodule ConstanceWeb.DefaultController do
  use ConstanceWeb, :controller

  def index(conn, _params) do
    text conn, "Welcome to Least Recently Used Cache."
  end
end