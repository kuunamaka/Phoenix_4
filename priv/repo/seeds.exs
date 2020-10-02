# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodoTutorial.Repo.insert!(%TodoTutorial.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TodoTutorial.Todo

for assign <- ~w(Maui Tasuku Rita) do
  Todo.create_assign!(assign)
end
