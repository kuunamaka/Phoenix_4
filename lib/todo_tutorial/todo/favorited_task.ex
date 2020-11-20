defmodule TodoTutorial.Todos.FavoritedTask do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          task_id: integer,
          user_id: integer
        }

  schema "favorited_tasks" do
    belongs_to :task, TodoTutorial.Todos.Task
    belongs_to :user, TodoTutorial.Accounts.User
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(favorited_task, attrs) do
    favorited_task
    |> cast(attrs, [:task_id, :user_id])
    |> foreign_key_constraint(:task_id)
    |> foreign_key_constraint(:user_id)
  end
end
