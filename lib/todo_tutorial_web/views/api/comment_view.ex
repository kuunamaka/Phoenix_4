defmodule TodoTutorialWeb.Api.CommentView do
  use TodoTutorialWeb, :view

  def render("task_comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      body: comment.body
    }
  end
end
