defmodule TodoTutorial.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :body, :string
      add :task_id, references(:tasks), null: false
    end
  end
end
