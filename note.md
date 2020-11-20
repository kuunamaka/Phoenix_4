docker-compose run app iex -S mix

docker-compose run app mix ecto.migrate
docker-compose run app mix ecto.migrations

docker-compose run app mix ecto.reset

mix test
mix test test/todo_tutorial/todo_test.exs

# server up/down
docker-compose up
docker-compose down
