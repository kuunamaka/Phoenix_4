defmodule TodoTutorialWeb.UserView do
  use TodoTutorialWeb, :view

  alias TodoTutorial.Accounts

  @doc """
  Splitting between its name's first and last
  """
  def first_name(%Accounts.User{name: name}) do
    hd([name])
  end
end
