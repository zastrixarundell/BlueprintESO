defmodule BlueprintESO.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BlueprintESO.Repo

  alias BlueprintESO.Accounts.{Character, Discord}

  @spec get_discord(integer() | String.t()) ::{:id, %Discord{}} | {:snowflake, %Discord{}} | {:error, :not_found}
  @doc """
  Gets a single discord from database wither via integer databse ID or Discord UID snowflake.

  Raises `Ecto.NoResultsError` if the Discord does not exist.

  ## Examples

      iex> get_discord(123)
      {:id, %Discord{}}

      iex> get_discord!("1235172374512")
      {:snowflake, %Discord{}}

      iex> get_discord!(456)
      {:error, Ecto.Changeset.t())

  """
  def get_discord(id) when is_integer(id) do
    case Repo.get(Discord, id) do
      nil ->
        {:error, :not_found}
      data ->
        {:id, data}
    end
  end

  def get_discord(uid) do
    case Repo.one(from d in Discord, where: d.uid == ^uid) do
      nil ->
        {:error, :not_found}
      data ->
        {:snowflake, data}
    end
  end

  @spec create_or_update_discord(auth :: %Ueberauth.Auth{}) :: {:ok, %Discord{}} | {:error, Ecto.Changeset.t()}
  @doc """
  Creates a discord from UeberAuth struct.

  ## Examples

      iex> create_or_update_discord(%Ueberauth.Auth{})
      {:ok, %Discord{}}

      iex> create_or_update_discord(%Ueberauth.Auth{})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_discord(auth) do
    uid = auth.uid

    discord =
      case get_discord(uid) do
        {:snowflake, data} ->
          data
        _ ->
          %Discord{}
      end

    token = auth.credentials.token
    refresh_token = auth.credentials.refresh_token
    name = auth.info.nickname

    discord
    |> Discord.changeset(%{uid: uid, token: token, refresh_token: refresh_token, name: name})
    |> Repo.insert_or_update()
  end

  @doc """
  Updates a discord.

  ## Examples

      iex> update_discord(discord, %{field: new_value})
      {:ok, %Discord{}}

      iex> update_discord(discord, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_discord(%Discord{} = discord, attrs) do
    discord
    |> Discord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a discord.

  ## Examples

      iex> delete_discord(discord)
      {:ok, %Discord{}}

      iex> delete_discord(discord)
      {:error, %Ecto.Changeset{}}

  """
  def delete_discord(%Discord{} = discord) do
    Repo.delete(discord)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking discord changes.

  ## Examples

      iex> change_discord(discord)
      %Ecto.Changeset{data: %Discord{}}

  """
  def change_discord(%Discord{} = discord, attrs \\ %{}) do
    Discord.changeset(discord, attrs)
  end

  alias BlueprintESO.Accounts.Character

  @doc """
  Returns the list of characters for the account.

  ## Examples

      iex> list_characters(%Discord{})
      [%Character{}, ...]

  """
  def list_account_characters(nil) do
    []
  end

  def list_account_characters(%Discord{} = account) do
    from(c in Character, where: c.discord_id == ^account.id, order_by: c.inserted_at)
    |> Repo.all()
  end

  @spec get_character(any) :: {:error, nil} | {:ok, %Character{}}
  def get_character(id) do
    case Repo.get(Character, id) do
      nil ->
        {:error, nil}
      data ->
        {:ok, data}
    end
  end

  @doc """
  Creates a character.

  ## Examples

      iex> create_character(%{field: value})
      {:ok, %Character{}}

      iex> create_character(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_character(attrs \\ %{}) do
    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a character.

  ## Examples

      iex> update_character(character, %{field: new_value})
      {:ok, %Character{}}

      iex> update_character(character, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_character(%Character{} = character, attrs) do
    character
    |> Character.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a character.

  ## Examples

      iex> delete_character(character)
      {:ok, %Character{}}

      iex> delete_character(character)
      {:error, %Ecto.Changeset{}}

  """
  def delete_character(%Character{} = character) do
    Repo.delete(character)
  end
end
