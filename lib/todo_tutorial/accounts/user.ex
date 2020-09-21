defmodule TodoTutorial.Accounts.User do
  # ↓ Defined user struct earlier 
  # defstruct [:id, :name, :username]
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    
    timestamps()
  end

  def changeset(user, attrs) do # Accepts Accounts.User struct and attributes
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end
end