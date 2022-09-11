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
end
