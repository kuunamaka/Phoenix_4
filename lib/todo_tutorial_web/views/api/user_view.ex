defmodule TodoTutorialWeb.Api.UserView do
  use TodoTutorialWeb, :view
  alias TodoTutorialWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, __MODULE__, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, username: user.username}
  end
end
