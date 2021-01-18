defmodule SqliteMonitor.Model.Item do
  use Ecto.Schema
  @derive {Jason.Encoder, except: [:__meta__, :__struct__]} 
  schema "monitors" do
    field :name, :string
    field :type, :string
    field :paused, :boolean, default: false
    field :details, :string
    timestamps()
  end
end