defmodule TodoTutorialWeb.UserView do
  use TodoTutorialWeb, :view
  alias TodoTutorial.Accounts

  @doc """
  Splitting between its name's first and last

  hd([list])
  (→ this function's ality must be a list)

  ## Examples

      iex> first_name("Maui Sahashi")
      "Maui"

  """
  @spec first_name(TodoTutorial.Accounts.User.t()) :: User.t()
  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
