defmodule TodoTutorial.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query
  alias TodoTutorial.Repo
  alias TodoTutorial.Accounts.User
  alias TodoTutorial.Accounts
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.FavoritedTask

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  @spec list_tasks :: %Task{}
  def list_tasks do
    Task
    |> preload([:assign, :users])
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
    |> preload([:assign, :users])
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
  @spec create_task(String.t()) :: %Task{}
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
  @spec update_task(%Task{}, String.t()) :: %Task{}
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

      iex> create_assign!(%{field: value, field: value})
      {:ok, %Assignee{}}

  """
  @spec create_assign!(String.t(), String.t()) :: %User{}
  def create_assign!(name, username) do
    Repo.insert!(%User{name: name, username: username}, on_conflict: :nothing)
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

  @doc """
  Liking the task.

  ## Examples

      iex> favorite_task(%{task_id: 1, user_id: 1})
      {:ok, %FavoritedTask{}}

  Below worked with bare values of `favorite_controller`
  Repo.insert(%FavoritedTask{task_id: task.id, user_id: user.id})
  
  Need to add @spec create_favorite_task(integer, integer) :: %FavoritedTask{} as well
  """
 
  def create_favorite_task(task, user) do
    Repo.insert(%FavoritedTask{task_id: task.id, user_id: user.id})
  end
end
