defmodule TodoTutorial.TestHelpers do
  alias TodoTutorial.{
    Accounts,
    Todos
  }

  # testing whether i can create a new todo task
  def todo_fixture(%Accounts.User{} = user) do
    user =
      Enum.into(user, %{
        name: "A test name",
        assign: "Maui",
        is_finished: true
      })

    {:ok, _} = Todos.create_task(user)
  end
end
