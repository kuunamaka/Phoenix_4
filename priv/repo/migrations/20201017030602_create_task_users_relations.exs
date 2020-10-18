defmodule TodoTutorial.Repo.Migrations.CreateTaskUsersRelations do
  use Ecto.Migration

  def change do
    create table(:task_users_relations) do
      add :task_id, references(:tasks)
      add :user_id, references(:users)
    end

    create index(:task_users_relations, [:user_id, :task_id])

  end
end
