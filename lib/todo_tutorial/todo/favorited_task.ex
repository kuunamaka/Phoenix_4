defmodule TodoTutorial.Todos.FavoritedTask do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorited_tasks" do
    belongs_to :task, TodoTutorial.Todos.Task
    belongs_to :user, TodoTutorial.Accounts.User
  end

  def changeset(favorited_task, attrs) do
    favorited_task
    |> cast(attrs, [:task_id, :user_id])
    |> foreign_key_constraint(:task_id)
    |> foreign_key_constraint(:user_id)
  end
end
