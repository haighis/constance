defmodule SqliteMonitor.Model.Setting do
  use Ecto.Schema
  @derive {Jason.Encoder, except: [:__meta__, :__struct__]} 
  schema "settings" do
    field :key, :string
    field :value, :string
    timestamps()
  end
end