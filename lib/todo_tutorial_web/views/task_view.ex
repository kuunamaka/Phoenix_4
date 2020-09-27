defmodule TodoTutorialWeb.TaskView do
  use TodoTutorialWeb, :view

  def assign_select_options(assigned) do
    for assign <- assigned, do: {assign.name, assign.id}
  end
end
