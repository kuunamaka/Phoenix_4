<template>
  <table>
    <h2>Adding Task</h2>
    <div>
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
          <option disabled>Please select one from</option>
          <option v-for="task in tasks" :key="task.id">
            {{ task.assignee_id }}
          </option>
        </select>
      </div>
      <div>
        Already finished?
        <input type="checkbox" id="is_finished" v-model="is_finished" />
      </div>
    </div>
    <button @click="createTask">Submit</button>
    <a href="/tasks" class="button">Back</a>
  </table>
</template>

<script>
import axios from "axios";
export default {
  name: "add_task",
  data() {
    return {
      name: "",
      assignee_id: null,
      is_finished: false,
      tasks: null,
      errors: [],
    };
  },
  methods: {
    async createTask() {
      this.errors = [];
      if (!this.name) {
        this.errors.push("Name required");
      }
      if (!this.assignee_id) {
        this.errors.push("Assignee requied");
      }
      if (this.errors.length !== 0) {
        return;
      }
      await axios.post("/api/tasks", {
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
    const resp = await axios.get("/api/tasks");
    this.tasks = resp.data.tasks;
  },
};
</script>
