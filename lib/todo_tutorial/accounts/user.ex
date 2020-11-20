defmodule TodoTutorial.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t(),
          username: String.t()
        }

  schema "users" do
    field :name, :string
    field :username, :string

    many_to_many :favorited_tasks, TodoTutorial.Todos.Task, join_through: "favorited_tasks"

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any()},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end
end
