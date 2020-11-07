defmodule TodoTutorialWeb.Task.FavoriteController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.FavoritedTask
  alias TodoTutorial.Accounts
   
  @doc """
  The `id` inside of create() is from url(routes) that's shown below
  so it's an id from `task`:
  `PATCH/PUT /api/tasks/:id`

  l17; defining the regulated user for liking the task (user → "Maui")
  """
  def create(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by(name: "Maui")
    task = Todos.get_task!(task_id)
    like = Todos.create_favorite_task(task, user)

    conn
    |> put_flash(:info, "Task liked successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  @doc """
  Deletes the like (must be the same user)
  """
  def delete(conn, %{"id"=> id}) do
    task = Todos.get_fav_task!(id)
    unlike = Todos.delete_favorite_task(task)

  conn
    |> put_flash(:info, "Task unliked successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
