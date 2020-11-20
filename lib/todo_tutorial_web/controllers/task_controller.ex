defmodule TodoTutorialWeb.TaskController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task

  plug :load_assigned when action in [:new, :create, :edit, :update]

  @doc """
  Renders index.html page with taking all tasks
  """
  def index(conn, _params) do
    tasks = Todos.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  @doc """
  Renders new.html page with change_task function
  """
  def new(conn, _params) do
    changeset = Todos.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  If it successed to create a new task, it'll go to 
  index.html page.

  And if it failed to create a new task, won't allow to create a new task
  instead, it'll saty at the same page.
  """
  def create(conn, %{"task" => task_params}) do
    case Todos.create_task(task_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  Renders show.html page with details of id from get_task!(id)
  """
  def show(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    render(conn, "show.html", task: task)
  end

  @doc """
  Renders edit.html page after edited its id-task
  """
  def edit(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    changeset = Todos.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  @doc """
  When successfully updated the given task, it displays
  "Task is updated successfully!" and
  the page will back to its index.html page

  If it failed to update,
  it won't update the data and will go back to edit.html page
  """
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todos.get_task!(id)

    case Todos.update_task(task, task_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Task is updated successfully!")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  @doc """
  Deletes the task if only user clicked 
  """
  def delete(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    {:ok, _task} = Todos.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  defp load_assigned(conn, _) do
    assign(conn, :assigned, Todos.list_alphabetical_assigned())
  end
end
