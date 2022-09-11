defmodule BlueprintESO.Repo.Migrations.CreateDiscords do
  use Ecto.Migration

  def change do
    create table(:discords) do
      add :name, :string
      add :token, :string
      add :refresh_token, :string
      add :uid, :string

      timestamps()
    end
  end
end
