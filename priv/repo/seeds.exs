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

alias TodoTutorial.Todos

Enum.each(~w(Maui Tasuku Rita), &Todos.create_assign!(&1))
