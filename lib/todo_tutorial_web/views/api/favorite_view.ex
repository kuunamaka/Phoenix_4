defmodule TodoTutorialWeb.Api.FavoriteView do
  use TodoTutorialWeb, :view

  def render("empty.json", _) do
    %{}
  end
end
