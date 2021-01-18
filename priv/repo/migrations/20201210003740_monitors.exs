defmodule SqliteMonitor.Repo.Migrations.Monitors do
  use Ecto.Migration

  def change do
    create table(:monitors) do
      add :name, :string
      add :type, :string
      add :paused, :boolean, default: false
      add :details, :string
      timestamps()
    end
  end
end
