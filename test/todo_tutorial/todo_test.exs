defmodule TodoTutorial.TodosTest do
  use TodoTutorial.DataCase
  use ExUnit.Case, async: true

  alias TodoTutorial.Todos
  alias TodoTutorial.Todos.Task
  alias TodoTutorial.Todos.Comment

  describe "list_tasks/0, get_task!/1" do
    @valid_attrs %{
      finished_at: ~N[2010-04-17 14:00:00],
      is_finished: true,
      name: "some name",
    }
    @update_attrs %{
      finished_at: ~N[2011-05-18 15:01:01],
      is_finished: false,
      name: "some updated name"
    }
    @invalid_attrs %{}
    @valid_comment %{body: "comment test", task_id: 1}
    @invalid_comment %{body: "", task_id: 1}

    def task_fixture(attrs \\ %{}) do
      { :ok, task } =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_task()

      task
    end

    def comment_fixture(attrs \\ %{}) do
      { :ok, _ } =
        attrs
        |> Enum.into(@valid_comment)
        |> Todos.create_comment()
    end

    test "list all tasks" do
      task = task_fixture()
      assert Todos.list_tasks() == [task]
    end

    test "get the task with given id" do
      task = task_fixture()
      assert Todos.get_task!(task.id) == task
    end
  end

  describe "create_task/1" do
    test "with valid data" do
      now = %{NaiveDateTime.utc_now() | microsecond: {0, 0}}
      assert {:ok, %Task{} = task} = Todos.create_task(@valid_attrs)
      assert task.finished_at == now
      assert task.is_finished == true
      assert task.name == "some name"
    end

    test "with invalid data, returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_task(@invalid_attrs)
    end
  end

  describe "update_task/2" do
    test "update task with valid data" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todos.update_task(task, @update_attrs)
      assert task.finished_at == nil
      assert task.is_finished == false
      assert task.name == "some updated name"
    end
  end

  describe "delete_task/1, change_task/1" do
    test "delete the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todos.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todos.change_task(task)
    end
  end

  describe "list_comments/0" do
    test "list all comments" do
      comment = comment_fixture()
      assert Todos.list_comments == [comment]
    end
  end

  describe "get_comment!/1" do
    test "get one comment" do
      comment = comment_fixture(@valid_comment)
      assert Todos.get_comment!(comment.id) == comment
    end
  end

  describe "create_comment/1" do
    test "with valid data" do
      assert {:ok, _} = Todos.create_comment(@valid_comment)
    end

    test "with invalid data" do
      assert {:error, _changeset} = Todos.create_comment(@invalid_comment)
    end
  end

  describe "delete_comment/1" do
    test "delete the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Todos.delete_comment(comment)
    end
  end
end
