defmodule TodoTutorial.Todo do
  @moduledoc """
  The Todo context.
  """

  import Ecto.Query
  alias TodoTutorial.Repo
  alias TodoTutorial.Todo.Assign
  alias TodoTutorial.Todo.Task

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
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
  
  # created assign function
  def create_assign!(name) do
    Repo.insert!(%Assign{name: name}, on_conflict: :nothing)
  end

  # change1.ex
  # idの順番で並べる
  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def list_alphabetical_assigned do
    Assign
    |> alphabetical()
    |> Repo.all()
  end
end
