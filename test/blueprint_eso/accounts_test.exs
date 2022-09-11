defmodule BlueprintESO.AccountsTest do
  use BlueprintESO.DataCase

  alias BlueprintESO.Accounts

  describe "discords" do
    alias BlueprintESO.Accounts.Discord

    import BlueprintESO.AccountsFixtures

    @invalid_attrs %{name: nil, refresh_token: nil, token: nil, uid: nil}

    test "list_discords/0 returns all discords" do
      discord = discord_fixture()
      assert Accounts.list_discords() == [discord]
    end

    test "get_discord!/1 returns the discord with given id" do
      discord = discord_fixture()
      assert Accounts.get_discord!(discord.id) == discord
    end

    test "create_discord/1 with valid data creates a discord" do
      valid_attrs = %{name: "some name", refresh_token: "some refresh_token", token: "some token", uid: "some uid"}

      assert {:ok, %Discord{} = discord} = Accounts.create_discord(valid_attrs)
      assert discord.name == "some name"
      assert discord.refresh_token == "some refresh_token"
      assert discord.token == "some token"
      assert discord.uid == "some uid"
    end

    test "create_discord/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_discord(@invalid_attrs)
    end

    test "update_discord/2 with valid data updates the discord" do
      discord = discord_fixture()
      update_attrs = %{name: "some updated name", refresh_token: "some updated refresh_token", token: "some updated token", uid: "some updated uid"}

      assert {:ok, %Discord{} = discord} = Accounts.update_discord(discord, update_attrs)
      assert discord.name == "some updated name"
      assert discord.refresh_token == "some updated refresh_token"
      assert discord.token == "some updated token"
      assert discord.uid == "some updated uid"
    end

    test "update_discord/2 with invalid data returns error changeset" do
      discord = discord_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_discord(discord, @invalid_attrs)
      assert discord == Accounts.get_discord!(discord.id)
    end

    test "delete_discord/1 deletes the discord" do
      discord = discord_fixture()
      assert {:ok, %Discord{}} = Accounts.delete_discord(discord)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_discord!(discord.id) end
    end

    test "change_discord/1 returns a discord changeset" do
      discord = discord_fixture()
      assert %Ecto.Changeset{} = Accounts.change_discord(discord)
    end
  end
end
