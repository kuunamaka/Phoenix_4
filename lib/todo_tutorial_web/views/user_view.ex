defmodule TodoTutorialWeb.UserView do
  use TodoTutorialWeb, :view

  alias TodoTutorial.Accounts

  # Splitting b/w its name's first and last
  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
