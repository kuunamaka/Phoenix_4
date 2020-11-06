defmodule TodoTutorialWeb.Task.FavoriteController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.FavoritedTask
  alias TodoTutorial.Todos.Accounts
   
  @doc """
  The `id` inside of create() is from url(routes) that's shown below
  so it's an id from `task`:
  `PATCH/PUT /api/tasks/:id`

  l17; defining the regulated user for liking the task (user → "Maui")
  """
  def create(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by(name: "Maui")
    task = Todos.get_task!(task_id)
    likes = Todos.create_favorite_task(task, user)

    conn
    |> put_flash(:info, "Task liked successfully.")
    |> redirect(to: Routes.task_favorite_path(conn, :create))
  end
end
