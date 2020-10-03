defmodule TodoTutorial.Repo.Migrations.AddAssignIdToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :assign_id, references(:assigned) 
    end
  end
end
