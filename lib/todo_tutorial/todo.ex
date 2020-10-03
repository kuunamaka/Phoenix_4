defmodule TodoTutorial.Todos do
  @moduledoc """
  The Todo context.
  """

  import Ecto.Query
  alias TodoTutorial.Repo
  alias TodoTutorial.Todos.Assignee
  alias TodoTutorial.Todos.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Task
    |> preload([:assign])
    |> Repo.all()
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Task
    |> preload([:assign]) 
    |> Repo.get!(id)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    # %Ecto.Changeset{}へ変換
    |> Task.changeset(attrs)
    # DBヘinsertする。{:ok, task} or {:error, changeset}を返す
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task), do: Repo.delete(task)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
  
  @doc """
  A function for creating a place for `assigned_by`.
  """
  def create_assign!(name) do
    Repo.insert!(%Assignee{name: name}, on_conflict: :nothing)
  end

  defp alphabetical(query) do
    from c in query, order_by: c.name
  end

  def list_alphabetical_assigned do
    Assignee
    |> alphabetical()
    |> Repo.all()
  end
end
