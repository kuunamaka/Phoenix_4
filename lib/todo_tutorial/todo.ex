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
  alias TodoTutorial.Todos.Comment

  @doc """
  Returns a list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  @spec list_tasks :: Task.t()
  def list_tasks do
    Task
    |> preload([:assignee, :favorited_users, :comment])
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
    |> preload([:assignee, :favorited_users, :comment])
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

  """
  @spec create_task(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}
  ) :: Task.t()
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert!()
    |> Repo.preload([:assignee, :favorited_users, :comment])
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
    |> Repo.update!()
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
  For changing task **puting values to editting-form
  """
  @spec change_task(%Task{}, %{}) :: Ecto.Changeset.t()
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
    |> Repo.update()
  end

  @doc """
  Create a place for `assignee`.

  ## Examples

      iex> create_assign!(%{field: value, field: value})
      {:ok, %User{}}

  """
  @spec create_assign!(String.t(), String.t()) :: User.t()
  def create_assign!(name, username) do
    Repo.insert!(%User{name: name, username: username}, on_conflict: :nothing)
  end

  defp ordered_users(query) do
    order_by(query, asc: :name)
  end

  @doc """
  A function that lists users as the alphabetical order by using ordered_users() private function
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
    user = Accounts.get_user_by_id(user_id)
    Repo.get_by!(FavoritedTask, %{task_id: task.id, user_id: user.id})
  end

  @doc """
  Unliking the task
  """
  @spec delete_favorite_task(integer, User.t()) ::
          {:ok, FavoritedTask.t()} | {:error, Ecto.Changeset.t()}
  def delete_favorite_task(task_id, user) do
    favorited_task = Repo.one(FavoritedTask |> where(task_id: ^task_id, user_id: ^user.id))
    Repo.delete(favorited_task)
  end

  @doc """
  Checking whether the task was favored or not
  """
  @spec favorite_status(Task.t()) :: boolean()
  def favorite_status(task) do
    user = Accounts.get_user_by_name("Maui")
    query = FavoritedTask |> where(task_id: ^task.id, user_id: ^user.id)
    Repo.exists?(query)
  end

  @doc """
  list comments
  """
  @spec list_comments :: Comment.t()
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Get a single comment
  """
  @spec get_comment!(integer) :: Comment.t()
  def get_comment!(id) do
    Repo.get!(Comment, id)
  end

  @doc """
  Create a comment
  """
  @spec create_comment(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}) ::
          {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Delete a comment
  """
  @spec delete_comment(integer) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def delete_comment(comment_id) do
    comment_id
    |> get_comment!()
    |> Repo.delete()
  end
end
