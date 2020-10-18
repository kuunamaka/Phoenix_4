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

    many_to_many :tasks, TodoTutorial.Todos.Task, join_through: "task_users_relations"

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end
end
