defmodule TodoTutorial.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
    name: String.t(),
    username: String.t()
  }

  @spec has_many(t) :: [t] | TodoTutorial.Todos.Task.t()
  schema "users" do
    field :name, :string
    field :username, :string

    has_many :tasks, TodoTutorial.Todos.Task

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
