defmodule TodoTutorialWeb.Api.CommentController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.Comment

  action_fallback TodoTutorialWeb.FallbackController

  def index(conn, _params) do
    comment = Todos.list_comments()
    render(conn, "task_comment.json", comment: comment)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Todos.create_comment(comment_params) do

      conn
      |> put_status(:created)
      |> render("task_comment.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Todos.get_comment!(id)
    render(conn, "task_comment.json", comment: comment)
  end

  def edit(conn, %{"comment" => comment_params}) do
    comment = Todos.update_comment(comment_params)
    render(conn, "task_comment.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Todos.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Todos.update_comment(comment, comment_params) do
      render(conn, "task_comment.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Todos.get_comment!(id)

    with {:ok, %Comment{}} <- Todos.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
