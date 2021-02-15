defmodule TodoTutorialWeb.Task.FavoriteController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Accounts

  @doc """
  The `id` inside of create() is from url(routes) that's shown below
  so it's an id from `task`:
  `PATCH/PUT /api/tasks/:id`

  l17; defining the regulated user for liking the task (user → "Maui")
  """
  @spec create(any(), map()) :: any()
  def create(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by_name("Maui")
    task = Todos.get_task!(task_id)
    Todos.create_favorite_task(task, user)

    conn
    |> put_flash(:info, "Task liked successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  @doc """
  Deletes the like (must be the same user)
  """
  @spec delete(any(), map()) :: any()
  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user_by_name("Maui")
    fav_task = Todos.get_fav_task!(id)

    conn
    |> put_flash(:error, "Task unliked successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
