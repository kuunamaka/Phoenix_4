defmodule TodoTutorial.Todo.Assign do
  use Ecto.Schema
  import Ecto.Changeset

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
