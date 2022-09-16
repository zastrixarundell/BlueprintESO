defmodule BlueprintESOWeb.PageView do
  use BlueprintESOWeb, :view
  alias BlueprintESO.Accounts.Character
  use Timex

  @spec unix_destination_time(char :: %Character{collected_at: nil | NaiveDateTime.t()}) :: nil | integer()
  @doc """
  Gives the unix format destination of the destination time in UTC.

  ##Examples

      iex> unix_destination_time(%Chararcter{collcted_at: nil})
      nil

      iex> unix_destination_time(%Chararcter{})
      1663345965
  """
  def unix_destination_time(%Character{collected_at: nil}) do
    nil
  end

  def unix_destination_time(%Character{} = char) do
    char
    |> destination_time()
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.to_unix
  end

  @spec unix_start_time(char :: %Character{collected_at: nil | NaiveDateTime.t()}) :: nil | integer()
  @doc """
  Same as for `unix_destination_time/1` but for the start.
  """
  def unix_start_time(%Character{collected_at: nil}) do
    nil
  end

  def unix_start_time(%Character{} = char) do
    char.collected_at
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.to_unix()
  end

  def is_ready?(%Character{collected_at: nil}) do
    true
  end

  def is_ready?(%Character{} = char) do
    current_time() > destination_time(char)
  end

  defp destination_time(%Character{} = char) do
    char.collected_at
    |> Timex.shift(minutes: Character.get_minutes!(char))
  end

  defp current_time() do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
