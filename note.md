docker-compose run app iex -S mix phx.server

docker-compose run app mix ecto.migrate
docker-compose run app mix ecto.migrations

docker-compose run app mix ecto.reset

mix test test/todo_tutorial/todo_test.exs

# server up/down
docker-compose up
docker-compose down

# button color
/* like */
.fas {
  background-color: #e0245e;
  border-color: #e0245e;
}

/* unlike */
.far {
  background-color: #bbbbbb;
  border-color: #bbbbbb;
}

```elixir
iex(6)> Repo.insert(%FavoritedTask{task_id: 3, user_id: 1})
[debug] QUERY OK db=3.3ms decode=37.9ms queue=0.5ms idle=1969.0ms
INSERT INTO "favorited_tasks" ("task_id","user_id") VALUES ($1,$2) RETURNING "id" [3, 1]
{:ok,
 %TodoTutorial.Todos.FavoritedTask{
   __meta__: #Ecto.Schema.Metadata<:loaded, "favorited_tasks">,
   id: 4,
   task: #Ecto.Association.NotLoaded<association :task is not loaded>,
   task_id: 3,
   user: #Ecto.Association.NotLoaded<association :user is not loaded>,
   user_id: 1
 }}
```
```elixir
# FavoritedTaskのidまで取得する
iex(18)> favtask = TodoTutorial.Todos.get_fav_task!(9)
[debug] QUERY OK source="favorited_tasks" db=0.9ms idle=1092.7ms
SELECT f0."id", f0."task_id", f0."user_id" FROM "favorited_tasks" AS f0 WHERE (f0."id" = $1) [9]
%TodoTutorial.Todos.FavoritedTask{
  __meta__: #Ecto.Schema.Metadata<:loaded, "favorited_tasks">,
  id: 9,
  task: #Ecto.Association.NotLoaded<association :task is not loaded>,
  task_id: 3,
  user: #Ecto.Association.NotLoaded<association :user is not loaded>,
  user_id: 2
}
iex(19)> favtask.id
9
```
```elixir
# FavoritedTaskのidまで取得する　その２
iex(23)> fav_tasks = %FavoritedTask{id: 18}
%TodoTutorial.Todos.FavoritedTask{
  __meta__: #Ecto.Schema.Metadata<:built, "favorited_tasks">,
  id: 18,
  task: #Ecto.Association.NotLoaded<association :task is not loaded>,
  task_id: nil,
  user: #Ecto.Association.NotLoaded<association :user is not loaded>,
  user_id: nil
}
iex(24)> fav_tasks.id
18
```
```elixir
# Adding the changeset inside of create_favorite_task/2 function -> works
iex(7)> defmodule Test do
...(7)>   def test(task, user) do
...(7)>     %FavoritedTask{}
...(7)>     |> FavoritedTask.changeset(%{task_id: task.id, user_id: user.id})
...(7)>     |> Repo.insert()
...(7)>   end
...(7)> end
{:module, Test,
 <<70, 79, 82, 49, 0, 0, 7, 96, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 237,
   0, 0, 0, 22, 11, 69, 108, 105, 120, 105, 114, 46, 84, 101, 115, 116, 8, 95,
   95, 105, 110, 102, 111, 95, 95, 7, 99, ...>>, {:test, 2}}
iex(8)> task = Repo.get!(Task, 1)
[debug] QUERY OK source="tasks" db=132.2ms decode=37.7ms queue=0.6ms idle=996.2ms
SELECT t0."id", t0."finished_at", t0."is_finished", t0."name", t0."assign_id", t0."inserted_at", t0."updated_at" FROM "tasks" AS t0 WHERE (t0."id" = $1) [1]
%TodoTutorial.Todos.Task{
  __meta__: #Ecto.Schema.Metadata<:loaded, "tasks">,
  assign: #Ecto.Association.NotLoaded<association :assign is not loaded>,
  assign_id: 1,
  finished_at: ~N[2020-11-13 10:00:52],
  id: 1,
  inserted_at: ~N[2020-10-29 00:05:28],
  is_finished: true,
  name: "do laundries",
  updated_at: ~N[2020-11-13 10:00:52],
  users: #Ecto.Association.NotLoaded<association :users is not loaded>
}
iex(9)> user = Repo.get!(User, 1)
[debug] QUERY OK source="users" db=5.2ms queue=0.3ms idle=1658.4ms
SELECT u0."id", u0."name", u0."username", u0."inserted_at", u0."updated_at" FROM "users" AS u0 WHERE (u0."id" = $1) [1]
%TodoTutorial.Accounts.User{
  __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
  id: 1,
  inserted_at: ~N[2020-10-29 00:05:03],
  name: "Maui",
  tasks: #Ecto.Association.NotLoaded<association :tasks is not loaded>,
  updated_at: ~N[2020-10-29 00:05:03],
  username: "kuunamaka"
}
iex(10)> Test.test(task, user)
[debug] QUERY OK db=4.8ms queue=0.5ms idle=727.7ms
INSERT INTO "favorited_tasks" ("task_id","user_id") VALUES ($1,$2) RETURNING "id" [1, 1]
{:ok,
 %TodoTutorial.Todos.FavoritedTask{
   __meta__: #Ecto.Schema.Metadata<:loaded, "favorited_tasks">,
   id: 28,
   task: #Ecto.Association.NotLoaded<association :task is not loaded>,
   task_id: 1,
   user: #Ecto.Association.NotLoaded<association :user is not loaded>,
   user_id: 1
 }}
```
