defmodule TodoTutorialWeb.Api.CommentController do
  @moduledoc """
  API Comment Controller
  """
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Comment

  action_fallback TodoTutorialWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    comment = Todos.list_comments()
    render(conn, "task_comment.json", comment: comment)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
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

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    comment = Todos.get_comment!(id)
    render(conn, "task_comment.json", comment: comment)
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    case Todos.delete_comment(id) do
      {:ok, %Comment{}} ->
        send_resp(conn, :no_content, "")

      {:error, _} ->
        conn
          |> put_status(:not_acceptable)
          |> render("")
    end
  end
end
