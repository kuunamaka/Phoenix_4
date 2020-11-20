defmodule TodoTutorial.TodosTest do
  use TodoTutorial.DataCase
  use ExUnit.Case, async: false

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Assignee

  describe "tasks" do
    alias TodoTutorial.Todos.Task

    @valid_attrs %{finished_at: ~N[2010-04-17 14:00:00], is_finished: true, name: "some name"}
    @update_attrs %{
      finished_at: ~N[2011-05-18 15:01:01],
      is_finished: false,
      name: "some updated name"
    }
    @invalid_attrs %{finished_at: nil, is_finished: nil, name: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todos.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todos.get_task!(task.id) == task
    end

    @doc """
    時刻をtest -> `now`variableを作成して時刻比較を行う
    """
    test "create_task/1 with valid data creates a task" do
      now = %{NaiveDateTime.utc_now() | microsecond: {0, 0}}
      assert {:ok, %Task{} = task} = Todos.create_task(@valid_attrs)
      assert task.finished_at == now
      assert task.is_finished == true
      assert task.name == "some name"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todos.update_task(task, @update_attrs)
      assert task.finished_at == nil
      assert task.is_finished == false
      assert task.name == "some updated name"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_task(task, @invalid_attrs)
      assert task == Todos.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todos.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todos.change_task(task)
    end

    test "list_alphabetical_ordered_users/0" do
      Enum.each(~w(Maui Tasuku Rita), &Todos.create_assign!(&1))

      alpha_names = Enum.map(Todos.list_alphabetical_assigned(), & &1.name)

      assert alpha_names == ~w(Maui Rita Tasuku)
    end
  end
end
