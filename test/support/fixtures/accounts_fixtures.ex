defmodule BlueprintESO.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlueprintESO.Accounts` context.
  """

  @doc """
  Generate a discord.
  """
  def discord_fixture(attrs \\ %{}) do
    {:ok, discord} =
      attrs
      |> Enum.into(%{
        name: "some name",
        refresh_token: "some refresh_token",
        token: "some token",
        uid: "some uid"
      })
      |> BlueprintESO.Accounts.create_discord()

    discord
  end

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        class: 42,
        collected_at: ~N[2022-09-12 19:28:00],
        collected_type: 42,
        name: "some name"
      })
      |> BlueprintESO.Accounts.create_character()

    character
  end
end
