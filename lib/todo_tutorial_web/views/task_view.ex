defmodule TodoTutorialWeb.TaskView do
  use TodoTutorialWeb, :view
  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Accounts.User

  @doc """
  A function for selecting assignee when adding a task
  """
  @spec assign_select_options(any()) :: [any()]
  def assign_select_options(assignee) do
    for assign <- assignee, do: {assign.name, assign.id}
  end

  @doc """
  For finding the id of FavoritedTask (for deleting the like)
  """
  @spec favtask(integer, integer) :: FavoritedTask.t()
  def favtask(task_id, user_id) do
    Todos.find_favorite_task(task_id, user_id)
  end

  @doc """
  Checking whether the task was favorited or not
  """
  @spec did_favorite?(Task.t(), User.t()) :: boolean()
  def did_favorite?(task, user) do
    Enum.member?(task.favorited_users, user)
  end
end
