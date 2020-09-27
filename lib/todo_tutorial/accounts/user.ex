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

  # 新しいuser作成時のみに確認する事項
  def changeset(user, attrs) do # Accepts Accounts.User struct and attributes
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end
end