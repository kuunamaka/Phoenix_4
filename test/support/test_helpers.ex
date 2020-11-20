defmodule TodoTutorial.TestHelpers do
  alias TodoTutorial.{
    Accounts,
    Todos
  }

  # testing whether i can create a new todo task
  def todo_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "A test name",
        assign: "Maui",
        is_finished: true
      })

    {:ok, task} = Todos.create_task(user, attrs)
  end
end
