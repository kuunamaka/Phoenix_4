defmodule TodoTutorialWeb.ErrorView do
  use TodoTutorialWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  @doc """
  A function for redering `404.html` file and 
  displaying "Not Found" page
  """
  def render("404.html", _assigns) do
    "Not Found"
  end

  @doc """
  A function for redering `500.html` file and 
  displaying "Internal Server Error" page
  """
  def render("500.html", _assigns) do
    "Internal Server Error"
  end
end
