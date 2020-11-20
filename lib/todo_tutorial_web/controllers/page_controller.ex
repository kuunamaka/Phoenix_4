defmodule TodoTutorialWeb.PageController do
  use TodoTutorialWeb, :controller

  @doc """
  A function for rendering `index.html`
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
