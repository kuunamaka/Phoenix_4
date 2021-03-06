# terminal/ console
*Deleting     ctrl a + k
*At the end   ctrl e
*forward      ctrl f
*back         ctrl b

# the directories
~/Phoenix_4   

# dockerの中に入る
$ docker-compose run app bash
## yarn test
cd assets
yran test

# command
`docker-compose run app iex -S mix phx.server`   

`docker-compose run app mix ecto.migrate`   
`docker-compose run app mix ecto.migrations`   

`docker-compose run app mix ecto.reset`   

`docker-compose run app mix test test/todo_tutorial/todo_test.exs`   

# async使ってjestでテストするとき
.babelrc
{
    "presets": [
        [
            "@babel/preset-env", {
                "targets": {
                    "node": "current"
                }
            }
        ]
    ]
}

# vscodeのファイル編集権限をuserにするとき
`$ sudo chown -R [ユーザー名] ./`   
`ls -la` で確認しておくのも大事！   

# github上のファイルの状態に戻す
`$ git checkout HEAD -- .`
(でも、変更させたくないファイルがあるときは`-- .` でなく
　ファイル名に変えること)

# server up/down
`docker-compose up`   
`docker-compose down`   

# button color
```css
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
```

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

12/18   
atoms...Buefyで提供されるデザインを細かくコンポーネント化したものを配置する   
molecules...atomsのコンポーネントを組み合わせて作成する（vuexとやり取りをしないこと）   
organisms...atoms, moleculesのコンポーネントを組み合わせて作成する（ここでvuexとやり取りする）   

12/30   
./templates/task/index.html.eexの元   
```html
<h1>Listing Tasks</h1>

<table>
  <thead>
    <script src="https://kit.fontawesome.com/d9f1380ea4.js" crossorigin="anonymous"></script>
    <tr>
      <th>Name</th>
      <th>Assigned by</th>
      <th>Is finished</th>
      <th>Finished at</th>
      <th>Likes</th>

      <th></th>
    </tr>
  </thead>
  <tbody>
    <%= for task <- @tasks do %>
      <tr>
        <td><%= task.name %></td>
        <td><%= task.assignee && task.assignee.name %></td>
        <td><%= task.is_finished %></td>
        <td><%= task.finished_at %></td>
        <td>
        <!-- if user was "Maui", then `delete`, otherwise goes to `create`/ fas=like/ far=unlike -->
          <%= if did_favorite?(task, @user) do %>
            <%= form_for TodoTutorial.Todos.FavoritedTask.changeset(favtask(task.id, @user.id), %{}),
              Routes.task_favorite_path(@conn, :delete, task.id, favtask(task.id, @user.id).id), [method: "delete"], fn _ -> %>
              <%= submit "", class: "fas fa-heart" %>
              <%= length(task.favorited_users) %>
            <% end %>
            <% else %>
              <%= form_for TodoTutorial.Todos.FavoritedTask.changeset(%TodoTutorial.Todos.FavoritedTask{}, %{task_id: task.id, user_id: @user.id}),
                Routes.task_favorite_path(@conn, :create, task.id), fn _ -> %>
                <%= submit "", class: "far fa-heart" %>
                <%= length(task.favorited_users) %>
              <% end %>
          <% end %>
        </td>

        <td>
          <span><%= link "Show", to: Routes.task_path(@conn, :show, task) %></span>
          <span> | </span>
          <span><%= link "Edit", to: Routes.task_path(@conn, :edit, task) %></span>
          <span> | </span>
          <span><%= link "Delete", to: Routes.task_path(@conn, :delete, task), method: :delete, data: [confirm: "Are you sure?"] %></span>
        </td>
      </tr>
    <% end %>
  </tbody>
</table>

<span><%= link "Add a new task", to: Routes.task_path(@conn, :new) %></span>
<span> | </span>
<span><%= link "See all the users", to: Routes.user_path(@conn, :index) %></span>
```
For selecting the assignee
```html
<div>
  Assigned by:
  <select v-model="selected">
    <option disabled>Please select one</option>
    <option v-for="task in tasks" :key="task.id">
      {{ task.assignee_id }}
    </option>
  </select>
</div>
```

## Comment feature test writing
```js
// comment_controller.ex
  def edit(conn, %{"comment" => comment_params}) do
    comment = Todos.update_comment(comment_params)
    render(conn, "task_comment.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Todos.get_comment!(id)

    case Todos.update_comment(comment, comment_params) do
      {:ok, %Comment{} = comment} ->
        render(conn, "task_comment.json", comment: comment)

      {:eroor, _} ->
        conn
          |> put_status(:not_acceptable)
          |> render("task_comment.json")
    end
  end

```
