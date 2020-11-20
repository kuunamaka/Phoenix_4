defmodule TodoTutorial.Accounts do
  @moduledoc """
  The Accounts context. Storing all the information of default users.

  Just a quick note to remind the names and usernames
    def list_users do
      [
        %User{name: "Maui", username: "kuunamaka"},
        %User{name: "Rita", username: "ritarita"},
        %User{name: "Tasuku", username: "kaleolani"}
      ]
    end

  """
  import Ecto.Query
  alias TodoTutorial.Repo
  alias TodoTutorial.Accounts.User

  @doc """
  Function for finding the user with their id

  ## Examples

      iex> get_user!(1)
      %User{}

  """
  @spec get_user(integer) :: User.t()
  def get_user(id), do: Repo.get(User, id)

  @doc """
  For getting the specified user-info

  ## Examples

      iex> get_user_by_id(id: 1)
      %User{
        id: 1,
        name: "Maui"
      }

  """
  @spec get_user_by_id(%{id: integer}) :: User.t()
  def get_user_by_id(params), do: Repo.get_by(User, params)

  @doc """
  For matching list attributes (name)

  ## Examples

      iex> get_user_by_name(name: "Maui")
      %User{
        id: 1,
        name: "Maui"
      }

  """
  @spec get_user_by_name(name: String.t()) :: User.t()
  def get_user_by_name(params), do: Repo.get_by(User, params)

  @doc """
  For listing all the users

  ## Examples

      iex> list_users
      [%User{}, ...]

  """
  @spec list_users :: User.t()
  def list_users do
    User
    |> preload([:favorited_tasks])
    |> Repo.all()
  end

  @doc """
  For changing the details/information of a user

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  @spec change_user(%User{}) :: Ecto.Changeset.t()
  def change_user(%User{} = user), do: User.changeset(user, %{})

  @doc """
  For connecting the new user to the controller

  double-back-slash is defining the default params for the input

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(any()) :: any()
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  For updating the user

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_user(
          User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}
        ) :: any()
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  For deeting the user that you specified

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_user(User.t()) :: any()
  def delete_user(%User{} = user), do: Repo.delete(user)
end
