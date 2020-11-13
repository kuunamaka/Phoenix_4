docker-compose run app iex -S mix phx.server

docker-compose run app mix ecto.migrate
docker-compose run app mix ecto.migrations

docker-compose run app mix ecto.reset

mix test test/todo_tutorial/todo_test.exs

# server up/down
docker-compose up
docker-compose down


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


# 一応呼べる
iex(26)> Repo.all(FavoritedTask |> where(id: 3))
[debug] QUERY OK source="favorited_tasks" db=1.3ms queue=3.2ms idle=178.9ms
SELECT f0."id", f0."task_id", f0."user_id" FROM "favorited_tasks" AS f0 WHERE (f0."id" = 3) []
[
  %TodoTutorial.Todos.FavoritedTask{
    __meta__: #Ecto.Schema.Metadata<:loaded, "favorited_tasks">,
    id: 3,
    task: #Ecto.Association.NotLoaded<association :task is not loaded>,
    task_id: 1,
    user: #Ecto.Association.NotLoaded<association :user is not loaded>,
    user_id: 1
  }
]

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
