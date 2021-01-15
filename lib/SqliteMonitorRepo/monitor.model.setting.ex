defmodule SqliteMonitor.Model.Setting do
  use Ecto.Schema
  schema "settings" do
    field :key, :string
    field :value, :string
    timestamps()
  end
end