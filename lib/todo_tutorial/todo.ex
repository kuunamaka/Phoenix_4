defmodule TodoTutorial.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query
  alias TodoTutorial.Repo
  alias TodoTutorial.Accounts.User
  alias TodoTutorial.Todos.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  @spec list_tasks :: %Task{}
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
  @spec get_task!(integer) :: %Task{}
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
  @spec create_task(string) :: %Task{}
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
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
  @spec update_task(%Task{}, string) :: %Task{}
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
  @spec delete_task(%Task{}) :: Repo.delete()
  def delete_task(%Task{} = task), do: Repo.delete(task)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  @spec change_task(%Task{}, %{}) :: Task.changeset()
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
  
  @doc """
  Create a place for `assigned_by`.

  ## Examples

      iex> create_assign!(%{field: value})
      {:ok, %Assignee{}}

  """
  @spec create_assign!(string) :: %User{}
  def create_assign!(name) do
    Repo.insert!(%User{name: name}, on_conflict: :nothing)
  end

  @doc """
  A function that makes the order by its params name
  """
  defp alphabetical(query) do
    from c in query, order_by: c.name
  end

  @doc """
  A function that lists the assignees as the alphabetical order by using alphabetical() private function

  ## Examples
      iex> list_alphabetical_assigned
      %User{}
  """
  @spec list_alphabetical_assigned :: %User{}
  def list_alphabetical_assigned do
    User
    |> alphabetical()
    |> Repo.all()
  end
end
