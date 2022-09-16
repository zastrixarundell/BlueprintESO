defmodule BlueprintESO.Accounts.Discord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discords" do
    field :name, :string
    field :refresh_token, :string
    field :token, :string
    field :uid, :string
    has_many :characters, BlueprintESO.Accounts.Character

    timestamps()
  end

  @doc false
  def changeset(discord, attrs) do
    discord
    |> cast(attrs, [:name, :token, :refresh_token, :uid])
    |> validate_required([:name, :token, :refresh_token, :uid])
  end
end
