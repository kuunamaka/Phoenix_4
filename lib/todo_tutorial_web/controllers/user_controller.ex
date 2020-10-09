defmodule TodoTutorialWeb.UserController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Accounts
  alias TodoTutorial.Accounts.User

  @doc """
  Renders index.html page with taking all users
  """
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  @doc """
  Renders show.html page with details of id from get_user(id)
  """
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  @doc """
  Renders new.html page with change_user function
  """
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  If it successed to create a new user, it'll go to 
  index.html page.

  And if it failed to create a new user, won't allow it to create a new user
  instead, it'll stay at the same page.
  """
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

  @doc """
  Renders edit.html page after edited its id-user
  """
  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  @doc """
  When successfully updated the given user, it displays
  "{user.name} is updated successfully!" and
  the page will back to its index.html page

  If it failed to update,
  it won't update the data and will go back to edit.html page
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)
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

  @doc """
  Deletes the user if only user clicked 
  """
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
