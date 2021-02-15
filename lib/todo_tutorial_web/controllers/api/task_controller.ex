defmodule TodoTutorialWeb.Api.TaskController do
  @moduledoc """
  API Task Controller
  """
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task

  action_fallback TodoTutorialWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    tasks = Todos.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"task" => task_params}) do
    task = Todos.create_task(task_params)

    conn
    |> put_status(:created)
    |> render("show.json", task: task)
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    render(conn, "show.json", task: task)
  end

  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"task" => task_params}) do
    task = Todos.change_task(task_params)
    render(conn, "show.json", task: task)
  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todos.get_task!(id)

    case Todos.update_task(task, task_params) do
      {:ok, %Task{} = task} ->
        render(conn, "show.json", task: task)
      {:error, _} ->
        conn
        |> put_status(:not_acceptable)
        |> render("show.json")
    end
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    task = Todos.get_task!(id)

    case Todos.delete_task(task) do
      {:ok, %Task{}} ->
        send_resp(conn, :no_content, "")
      {:error, _} ->
        conn
        |> put_status(:not_acceptable)
        |> render("")
    end
  end
end
