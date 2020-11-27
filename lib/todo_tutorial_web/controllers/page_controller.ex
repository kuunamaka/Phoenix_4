defmodule TodoTutorialWeb.PageController do
  use TodoTutorialWeb, :controller

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  @doc """
  A function for rendering `index.html`
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
