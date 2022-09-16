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

  describe "characters" do
    alias BlueprintESO.Accounts.Character

    import BlueprintESO.AccountsFixtures

    @invalid_attrs %{class: nil, collected_at: nil, collected_type: nil, name: nil}

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Accounts.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Accounts.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      valid_attrs = %{class: 42, collected_at: ~N[2022-09-12 19:28:00], collected_type: 42, name: "some name"}

      assert {:ok, %Character{} = character} = Accounts.create_character(valid_attrs)
      assert character.class == 42
      assert character.collected_at == ~N[2022-09-12 19:28:00]
      assert character.collected_type == 42
      assert character.name == "some name"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      update_attrs = %{class: 43, collected_at: ~N[2022-09-13 19:28:00], collected_type: 43, name: "some updated name"}

      assert {:ok, %Character{} = character} = Accounts.update_character(character, update_attrs)
      assert character.class == 43
      assert character.collected_at == ~N[2022-09-13 19:28:00]
      assert character.collected_type == 43
      assert character.name == "some updated name"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_character(character, @invalid_attrs)
      assert character == Accounts.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Accounts.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Accounts.change_character(character)
    end
  end
end
