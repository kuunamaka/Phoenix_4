defmodule TodoTutorial.Repo.Migrations.CreateAssigned do
  use Ecto.Migration

  def change do
    create table(:assigned) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:assigned, [:name])
  end
end

