defmodule TodoTutorial.Accounts do
  @moduledoc """
  The Accounts context. Storing all the information of default users.

  Just a quick note to remind the name and username
    def list_users do
      [
        %User{name: "Maui", username: "kuunamaka"},
        %User{name: "Rita", username: "ritarita"},
        %User{name: "Tasuku", username: "kaleolani"}
      ]
    end

  """
  alias TodoTutorial.Repo
  alias TodoTutorial.Accounts.User

  @doc """
  Function for finding the user with their id
  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  For matching list attributes
  """
  def get_user_by(params), do: Repo.get_by(User, params)
  
  def list_users, do: Repo.all(User)

  def change_user(%User{} = user), do: User.changeset(user, %{})

  @doc """
  For connecting the new user to the controller 
  """
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

  def delete_user(%User{} = user), do: Repo.delete(user)
end
