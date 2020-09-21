docker-compose run app iex -S mix

docker-compose run app mix ecto.migrate
docker-compose run app mix ecto.migrations

mix ecto.reset

# server up/down
docker-compose up
docker-compose down
