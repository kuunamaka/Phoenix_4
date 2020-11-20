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
  @spec list_tasks :: Task.t()
  def list_tasks do
    Task
    |> preload([:assigned_user, :favorited_users])
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
  @spec get_task!(integer) :: Task.t()
  def get_task!(id) do
    Task
    |> preload([:assigned_user, :favorited_users])
    |> Repo.get!(id)
  end

  @doc """
  Gets a single favorited task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_fav_task!(123)
      %FavoritedTask{}

      iex> get_fav_task!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_fav_task!(integer) :: FavoritedTask.t()
  def get_fav_task!(id) do
    Repo.get!(FavoritedTask, id)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_task(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}) ::
          {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
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
  @spec update_task(
          TodoTutorial.Todos.Task.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}
        ) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
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
  @spec delete_task(%Task{}) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def delete_task(%Task{} = task), do: Repo.delete(task)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  @spec change_task(%Task{}, %{}) :: Ecto.Changeset.t()
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  @doc """
  Create a place for `assigned_by`.

  ## Examples

      iex> create_assign!(%{field: value, field: value})
      {:ok, %Assignee{}}

  """
  @spec create_assign!(String.t(), String.t()) :: User.t()
  def create_assign!(name, username) do
    Repo.insert!(%User{name: name, username: username}, on_conflict: :nothing)
  end

  defp ordered_users(query) do
    order_by(query, asc: :name)
  end

  @doc """
  A function that lists the assignees as the alphabetical order by using alphabetical() private function

  ## Examples
      iex> list_alphabetical_ordered_users
      %User{}
  """
  @spec list_alphabetical_ordered_users :: User.t()
  def list_alphabetical_ordered_users do
    User
    |> ordered_users()
    |> Repo.all()
  end

  @doc """
  Liking the task.

  ## Examples

      iex> create_favorite_task(%{task_id: 1, user_id: 1})
      {:ok, %FavoritedTask{}}

  """
  @spec create_favorite_task(Task.t(), User.t()) ::
          {:ok, FavoritedTask.t()} | {:error, Ecto.Changeset.t()}
  def create_favorite_task(task, user) do
    %FavoritedTask{}
    |> FavoritedTask.changeset(%{task_id: task.id, user_id: user.id})
    |> Repo.insert()
  end

  @doc """
  Finding the FavoritedTask's id
  """
  @spec find_favorite_task(integer, integer) :: FavoritedTask.t()
  def find_favorite_task(task_id, user_id) do
    task = get_task!(task_id)
    user = Accounts.get_user(user_id)
    Repo.get_by!(FavoritedTask, %{task_id: task.id, user_id: user.id})
  end

  @doc """
  Unliking the task

  ## Examples

      iex> delete_favorite_task(%{id: 1})
      {:ok, %FavoritedTask{}}

  id = a primary key

  """
  @spec delete_favorite_task(FavoritedTask.t()) ::
          {:ok, FavoritedTask.t()} | {:error, Ecto.Changeset.t()}
  def delete_favorite_task(task) do
    Repo.delete(%FavoritedTask{id: task.id})
  end
end
