defmodule TodoTutorialWeb.TaskView do
  use TodoTutorialWeb, :view

  @doc """
  A function for selecting the assigning user when adding a task
  """
  def assign_select_options(assigned) do
    for assign <- assigned, do: {assign.name, assign.id}
  end

  @doc """
  need to write the function for finding the id for FavoritedTask by next Friday
  """
end
