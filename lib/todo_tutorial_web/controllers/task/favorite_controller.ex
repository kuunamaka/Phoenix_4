defmodule TodoTutorialWeb.Task.FavoriteController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.FavoritedTask
  alias TodoTutorial.Todos.Accounts
   
  @doc """
  The `id` inside of create() is from url that shown below
  so it's a id from task:
  `PATCH/PUT /api/tasks/:id`

  l17; defining the regulation user for liking the task (user → "Maui")
  """
  def create(conn, %{"task_id" => task_id}) do
    user = Accounts.get_user_by(name: "Maui")
    task = Todos.get_task!(task_id)
    likes = Todos.create_favorite_task(task, user.id)
    render(conn, "index.html", task: task, likes: likes)
  end
end
