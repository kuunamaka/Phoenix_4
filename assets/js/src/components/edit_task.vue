<template>
  <table>
    <div>
      <h2>Updating Task</h2>
      <p v-if="errors.length">Please correct the following error(s):</p>

      <ul>
        <li v-for="error in errors" :key="error" class="error">{{ error }}</li>
      </ul>
      <div>
        Name
        <input v-model="name" />
      </div>
      <div>
        Assigned by:
        <select v-model="assignee_id">
          <option disabled>Please select one</option>
          <option>
            {{ task.assignee_id }}
          </option>
        </select>
      </div>
      <div>
        Has finished?
        <input type="checkbox" id="is_finished" v-model="is_finished" />
      </div>
      <button @click="updateTask(task)">Submit</button>
      <a href="/tasks" class="button">Exit</a>
    </div>
    <delete-task />
  </table>
</template>

<script>
import axios from "axios";
import DeleteTask from "./delete_task";
export default {
  name: "edit_task",
  components: { DeleteTask },
  data() {
    return {
      name: "",
      assignee_id: null,
      is_finished: false,
      task: "",
      errors: [],
    };
  },
  methods: {
    async updateTask(task) {
      this.errors = [];
      if (!this.name) {
        this.errors.push("Name required");
      }
      if (!this.assignee_id) {
        this.errors.push("Assignee required");
      }
      if (this.errors.length !== 0) {
        return;
      }
      await axios.put(`/api/tasks/${task.id}`, {
        task: {
          name: this.name,
          is_finished: this.is_finished,
          assignee_id: this.assignee_id,
        },
      });
      window.location.href = "/tasks";
    },
  },
  async mounted() {
    const task_id = window.location.pathname.split("/")[2];
    const resp = await axios.get(`/api/tasks/${task_id}`);
    this.task = resp.data;
  },
};
</script>
