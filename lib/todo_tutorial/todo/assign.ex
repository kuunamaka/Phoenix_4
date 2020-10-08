defmodule TodoTutorial.Todos.Assignee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assigned" do
    field :name, :string

    has_many :tasks, TodoTutorial.Todos.Task

    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
