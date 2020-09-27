defmodule TodoTutorial.AccountsTest do
  use TodoTutorial.DataCase, async: true

  alias TodoTutorial.Accounts
  alias TodoTutorial.Accounts.User

  describe "create_user/1" do
    @valid_attrs %{
      name: "User",
      username: "testuser"
    }
    @invalid_attrs %{}

    test "with valid data inserts user" do
      assert {:ok, %User{id: id}=user} = Accounts.create_user(@valid_attrs)
      assert user.name == "User"
      assert user.username == "testuser"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.create_user(@invalid_attrs)
      assert Accounts.list_users() == []
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id}} = Accounts.create_user(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(@valid_attrs)

      assert %{username: ["has already been taken"]} =
        errors_on(changeset)

      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "does not accept long username" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
      {:error, changeset} = Accounts.create_user(attrs)

      assert %{username: ["should be at most 20 character(s)"]} =
        errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end
end