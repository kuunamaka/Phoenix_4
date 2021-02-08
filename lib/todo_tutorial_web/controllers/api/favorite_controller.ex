defmodule TodoTutorialWeb.Api.FavoriteController do
  @moduledoc """
  Favorite controller for Api
  """
  use TodoTutorialWeb, :controller
  alias TodoTutorial.Todos
  alias TodoTutorial.Accounts
  alias TodoTutorial.Todos.FavoritedTask

  action_fallback TodoTutorialWeb.FallbackController

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by_name("Maui")
    task = Todos.get_task!(task_id)
    Todos.create_favorite_task(task, user)

    conn
    |> put_status(:created)
    |> render("empty.json")
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by_name("Maui")
    Todos.delete_favorite_task(task_id, user)

    conn
      |> put_status(:created)
      |> render("empty.json")
  end
end
