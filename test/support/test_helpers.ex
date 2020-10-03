defmodule TodoTutorial.TestHelpers do
  alias TodoTutorial.{
    Accounts,
    Todo
  }

  # testing whether i can create a new todo task
  def todo_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "A test name",
        assign: "Maui",
        is_finished: true
      })

    {:ok, task} = Todo.create_task(user, attrs)
  end
end
