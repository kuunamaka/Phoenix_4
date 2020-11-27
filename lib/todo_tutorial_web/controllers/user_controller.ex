defmodule TodoTutorialWeb.UserController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Accounts
  alias TodoTutorial.Accounts.User

  @doc """
  Renders index.html page with taking all users
  """
  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  @doc """
  Renders show.html page with details of id from get_user_by_id(id)
  """
  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user_by_id(id)
    render(conn, "show.html", user: user)
  end

  @doc """
  Renders new.html page with change_user function
  """
  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  If it successed to create a new user, it'll go to
  index.html page.

  And if it failed to create a new user, it won't allow it to create a new user
  instead, it'll stay the same page.
  """
  @spec create(any(), map()) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "User couldn't create successfully.")
        |> render("new.html", changeset: changeset)
    end
  end

  @doc """
  Renders edit.html page after edited its id-user
  """
  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user_by_id(id)
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
  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user_by_id(id)

    case Accounts.update_user(user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "#{user.name} is updated successfully!")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "#{user.name} coudn't update.")
        |> render("edit.html", user: user, changeset: changeset)
    end
  end

  @doc """
  Deletes the user if only user clicked
  """
  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user_by_id(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
