defmodule TodoTutorial.Todos.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
    body: String.t(),
    task_id: integer
  }

  schema "comment" do
    field :body, :string
    belongs_to :task, TodoTutorial.Todos.Task
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any()},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:task_id, :body])
    |> foreign_key_constraint(:task_id)
  end
end
