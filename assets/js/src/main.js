import Vue from "vue";
import user_list from "./components/user_list";
import add_user from "./components/add_user";
import edit_user from "./components/edit_user";
import delete_user from "./components/delete_user";
import task_list from "./components/task_list";
import add_task from "./components/add_task";
import edit_task from "./components/edit_task";
import delete_task from "./components/delete_task";
import task_detail from "./components/task_detail";

new Vue({
  el: "#app",
  components: {
    user_list,
    add_user,
    edit_user,
    delete_user,
    task_list,
    add_task,
    edit_task,
    delete_task,
    task_detail
  },
});
