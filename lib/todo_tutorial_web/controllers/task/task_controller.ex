defmodule TodoTutorialWeb.TaskController do
  use TodoTutorialWeb, :controller

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Accounts

  plug :load_assigned when action in [:new, :create, :edit, :update]

  @doc """
  Renders index.html page with all tasks
  """
  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    tasks = Todos.list_tasks()
    user = Accounts.get_user_by_name("Maui")
    render(conn, "index.html", tasks: tasks, user: user)
  end

  @doc """
  Renders new.html page with change_task function
  """
  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Todos.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  If it successed to create a new task, it'll go to
  index.html page.

  And if it failed to create a new task, won't allow to create a new task
  instead, it'll stay at the same page.
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"task" => task_params}) do
    case Todos.create_task(task_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Couldn't create task")
        |> render("new.html", changeset: changeset)
    end
  end

  @doc """
  Renders show.html page with details of id from get_task!(id)
  """
  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    render(conn, "show.html", task: task)
  end

  @doc """
  Renders edit.html page after changeed id-specified task
  """
  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    changeset = Todos.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  @doc """
  When successfully updated the given task, it displays
  "Task is updated successfully!" flash and
  the page will back to its index.html page

  If it failed to update,
  it won't update the data and will go back to edit.html page
  """
  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todos.get_task!(id)

    case Todos.update_task(task, task_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Task is updated successfully!")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Task couldn't update")
        |> render("edit.html", task: task, changeset: changeset)
    end
  end

  @doc """
  Deletes the task
  """
  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    {:ok, _task} = Todos.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  defp load_assigned(conn, _) do
    assign(conn, :assignee, Todos.list_alphabetical_ordered_users())
  end
end
