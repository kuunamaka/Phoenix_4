defmodule TodoTutorialWeb.UserView do
  use TodoTutorialWeb, :view

  alias TodoTutorial.Accounts

  @doc """
  Splitting between its name's first and last

  ## Examples

      iex> first_name("Maui Sahashi")
      "Maui"

  """
  @spec first_name(TodoTutorial.Accounts.User.t()) :: any
  def first_name(%Accounts.User{name: name}) do
    hd([name])
  end
end
