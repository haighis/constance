defmodule SqliteMonitor.Model.Item do
  use Ecto.Schema
  schema "monitors" do
    field :name, :string
    field :type, :string
    field :interval, :string
    field :details, :string
    timestamps()
  end
end