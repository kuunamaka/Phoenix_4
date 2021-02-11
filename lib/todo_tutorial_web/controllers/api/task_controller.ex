defmodule TodoTutorialWeb.Api.TaskController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task

  action_fallback TodoTutorialWeb.FallbackController

  def index(conn, _params) do
    tasks = Todos.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
     case Todos.create_task(task_params) do
      {:ok, %Task{} = task} ->
        id = task.id
        task = Todos.get_task!(id)
        IO.inspect(task)
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.api_task_path(conn, :show, task))
        |> render("show.json", task: task)

      {:error, _} ->
        conn
        |> put_status(:not_acceptable)
        |> render("show.json")
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def edit(conn, %{"task" => task_params}) do
    task = Todos.change_task(task_params)
    render(conn, "show.json", task: task)
  end

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
