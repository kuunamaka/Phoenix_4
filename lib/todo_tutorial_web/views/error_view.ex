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

  # Adding the 404 and 500 error view
  def render("404.html", _assigns) do
    "Page Not Found"
  end

  def render("500.html", _assigns) do
    "Internal Sever Error"
  end
end
