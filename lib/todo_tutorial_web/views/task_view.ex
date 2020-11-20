defmodule TodoTutorialWeb.TaskView do
  use TodoTutorialWeb, :view

  @doc """
  A function for the selection when adding a new task
  """
  def assign_select_options(assigned) do
    for assign <- assigned, do: {assign.name, assign.id}
  end
end
