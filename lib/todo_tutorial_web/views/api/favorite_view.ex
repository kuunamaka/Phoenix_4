defmodule TodoTutorialWeb.Api.FavoriteView do
  use TodoTutorialWeb, :view

  def render("task_favorite.json", _) do
    %{}
  end

  def render("task_favorite.json", %{favorited_users: favorited_users}) do
    %{
      id: favorited_users.id
    }
  end
end
