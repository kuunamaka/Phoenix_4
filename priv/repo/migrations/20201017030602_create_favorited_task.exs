defmodule TodoTutorial.Repo.Migrations.CreateFavoritedTask do
  use Ecto.Migration

  def change do
    create table(:favorited_tasks) do
      add :task_id, references(:tasks), null: false
      add :user_id, references(:users), null: false
    end

    create unique_index(:favorited_tasks, [:user_id, :task_id])

  end
end
