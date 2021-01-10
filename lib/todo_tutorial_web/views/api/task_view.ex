defmodule TodoTutorialWeb.Api.TaskView do
  use TodoTutorialWeb, :view

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, __MODULE__, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, __MODULE__, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      name: task.name,
      assignee: task.assignee && task.assignee.name,
      is_finished: task.is_finished,
      finished_at: task.finished_at,
      favorited_num: length(task.favorited_users),
      favorited_users: render_many(task.favorited_users, TodoTutorialWeb.Api.FavoriteView, "empty.json", as: :favorited_users),
      is_liked: TodoTutorial.Todos.favorite_status(task),
      assignee_id: task.assignee_id
    }
  end
end
