defmodule TodoTutorialWeb.TaskView do
  use TodoTutorialWeb, :view
  alias TodoTutorial.Todos

  @doc """
  A function for selecting the assigning user when adding a task
  """
  @spec assign_select_options(any()) :: [any()]
  def assign_select_options(assigned) do
    for assign <- assigned, do: {assign.name, assign.id}
  end

  @doc """
  For finding the id of FavoritedTask (for deleting the like)
  """
  @spec favtask(integer, integer) :: any()
  def favtask(task_id, user_id) do
    Todos.find_favorite_task(task_id, user_id)
  end
end
