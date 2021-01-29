defmodule TodoTutorialWeb.Api.FavoriteView do
  use TodoTutorialWeb, :view

  def render("empty.json", _) do
    %{}
  end

  def render("empty.json", %{favorited_users: favorited_users}) do
    %{
      id: favorited_users.id,
      length: length(favorited_users)
    }
  end
end
