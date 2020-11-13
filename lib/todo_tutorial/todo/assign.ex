defmodule TodoTutorial.Todos.Assignee do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t()
        }

  schema "assigned" do
    field :name, :string

    has_many :tasks, TodoTutorial.Todos.Task

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
