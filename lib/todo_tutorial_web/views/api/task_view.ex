defmodule TodoTutorialWeb.Api.TaskView do
  use TodoTutorialWeb, :view

  def render("index.json", %{tasks: tasks}) do
    %{tasks: render_many(tasks, __MODULE__, "task.json")}
  end

  def render("show.json", %{task: task}) do
    render_one(task, __MODULE__, "task.json")
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      name: task.name,
      assignee: task.assignee.name,
      is_finished: task.is_finished,
      finished_at: task.finished_at,
      favorited_users: render_many(task.favorited_users, TodoTutorialWeb.Api.FavoriteView, "task_favorite.json", as: :favorited_users),
      is_liked: TodoTutorial.Todos.favorite_status(task),
      assignee_id: task.assignee_id,
      comment: render_many(task.comment, TodoTutorialWeb.Api.CommentView, "task_comment.json", as: :comment),
    }
  end
end
