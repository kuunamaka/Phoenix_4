defmodule TodoTutorial.Repo.Migrations.AddAssignIdToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :assignee_id, references(:users)
    end
  end
end
