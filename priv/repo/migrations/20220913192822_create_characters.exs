defmodule BlueprintESO.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :class, :integer
      add :collected_at, :naive_datetime
      add :collected_type, :integer
      add :discord_id, references(:discords)

      timestamps()
    end
  end
end
