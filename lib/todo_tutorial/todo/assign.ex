defmodule TodoTutorial.Todos.Assignee do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoTutorial.Todos.Task

  schema "assigned" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
