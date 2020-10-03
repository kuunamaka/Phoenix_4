defmodule TodoTutorialWeb.TodoViewTest do
  use TodoTutorialWeb.ConnCase, async: true
  import Phoenix.View

  alias TodoTutorial.Todo.Task

  test "renders index.html", %{conn: conn} do
    tasks = [
      %TodoTutorial.Todo.Task{id: "1", name: "go for a walk"},
      %TodoTutorial.Todo.Task{id: "2", name: "do the dishes"}
    ]

    content =
      render_to_string(
        TodoTutorialWeb.TaskView,
        "index.html",
        conn: conn,
        tasks: tasks
      )

    assert String.contains?(content, "Listing Tasks")

    for tasks <- tasks do
      assert String.contains?(content, tasks.name)
    end
  end

  test "renders new.html", %{conn: conn} do
    owner = %TodoTutorial.Accounts.User{}
    changeset = TodoTutorial.Todo.change_task(%TodoTutorial.Todo.Task{})
    assigned = [%TodoTutorial.Todo.Task{id: 123, name: "wash the hands"}]

    content =
      render_to_string(TodoTutorialWeb.TaskView, "new.html",
        conn: conn,
        changeset: changeset,
        assigned: assigned
      )

    assert String.contains?(content, "New Task")
  end
end
