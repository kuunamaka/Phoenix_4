defmodule TodoTutorialWeb.Api.CommentController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Comment

  action_fallback TodoTutorialWeb.FallbackController

  def index(conn, _params) do
    comment = Todos.list_comments()
    render(conn, "task_comment.json", comment: comment)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Todos.create_comment(comment_params) do
      {:ok, %Comment{} = comment} ->
        conn
        |> put_status(:created)
        |> render("task_comment.json", comment: comment)

        {:error, _} ->
          conn
          |> put_status(:not_acceptable)
          |> render("task_comment.json")
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Todos.get_comment!(id)
    render(conn, "task_comment.json", comment: comment)
  end

  def delete(conn, %{"id" => id}) do
    comment = Todos.get_comment!(id)

    case Todos.delete_comment(comment) do
      {:ok, %Comment{}} ->
        send_resp(conn, :no_content, "")

      {:error, _} ->
        conn
          |> put_status(:not_acceptable)
          |> render("")
    end
  end
end
