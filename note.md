docker-compose run app iex -S mix

docker-compose run app mix ecto.migrate
docker-compose run app mix ecto.migrations

docker-compose run app mix ecto.reset

mix test
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
