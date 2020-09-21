defmodule TodoTutorial.Accounts do
  @moduledoc """
    THe Accounts context. Storing all the information of default users.

    前に使用していたやつ。name, usernameが分からなくなったとき用
    def list_users do
      [
        %User{id: "1", name: "Rita", username: "ritateto"},
        %User{id: "2", name: "Tasuku", username: "kyleswim"},
        %User{id: "3", name: "Maui", username: "kuunamaka"},
        %User{id: "4", name: "Kanae", username: "mommy"},
        %User{id: "5", name: "Myoku", username: "daddy"}
      ]
    end
  """
  alias TodoTutorial.Repo
  alias TodoTutorial.Accounts.User

  # Finding the user with their id
  # Enum.find()を使ってidが一致するものを探す
  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  # Matching list attributes
  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end

  # For new user
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # Connecting new user to out controller
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end