defmodule TodoTutorial.Accounts do
  @moduledoc """
    THe Accounts context. Storing all the information of default users.

    前に使用していたやつ。name, usernameが分からなくなったとき用
    def list_users do
      [
        %User{name: "Maui", username: "kuunamaka"},
        %User{name: "Rita", username: "ritarita"},
        %User{name: "Tasuku", username: "kaleolani"}
      ]
    end

    idに関しては、delete作業でバラバラなので、Repo.all(User)等で確認する
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

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # Connecting the new user to out controller
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end
