defmodule TodoTutorialWeb.UserController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Accounts
  alias TodoTutorial.Accounts.User
  alias TodoTutorial.Repo

  # Creating the route to `index.html` page
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  # Creating `show` function to show the specific user (by their ids)
  # Moving to `show.html` page
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  # Adding a new user
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Editing the existed user
  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)

    case Accounts.update_user(user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "#{user.name} is updated successfully!")
        |> redirect(to: Routes.user_path(conn, :show, user.id))
        
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  # Deleting the user
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end