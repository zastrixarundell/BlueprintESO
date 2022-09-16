defmodule BlueprintESO.Accounts.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :class, Ecto.Enum, values: [sorc: 0, nb: 1, templar: 2, dk: 3, warden: 4, necro: 5]
    field :collected_at, :naive_datetime
    field :collected_type, Ecto.Enum, values: [superior: 0, epic: 1]
    field :name, :string
    belongs_to :discord, BlueprintESO.Accounts.Discord

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :class, :collected_at, :collected_type, :discord_id])
    |> validate_required([:name, :class, :discord_id])
  end

  # @spec get_minutes!(%BlueprintESO.Accounts.Character{
  #         :collected_type => :epic | :superior,
  #       }) :: 30 | 1440
  @spec get_minutes!(%BlueprintESO.Accounts.Character{
          :collected_type => :epic | :superior
        }) :: 30 | 1440
  @doc """
  Get the minutes which are connected to the character drop type.any()

  ## Examples

      iex> get_minutes!(%Character{collected_type: :epic})
      1440

      iex> get_minutes!(%Character{collected_type: :superior})
      30
  """
  def get_minutes!(%__MODULE__{} = char) do
    case char.collected_type do
      :epic -> 1440
      :superior -> 30
    end
  end
end
