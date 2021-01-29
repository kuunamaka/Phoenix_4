<!-- adding a new task -->
<template>
  <table>
    <h2>Adding Task</h2>
    <div>
      <div>
        Name
        <input v-model="name">
      </div>
      <div>
        Assigned by:
        <select v-model="assignee_id">
          <option disabled>Please select one</option>
          <option v-for="task in tasks" :key="task.id">
            {{ task.assignee_id }}
          </option>
        </select>
      </div>
      <div>
        Already finished?
        <input type="checkbox" id="is_finished" v-model="is_finished">
      </div>
    </div>
    <button @click="createTask">Submit</button>
    <a href="/tasks" class="button">Back</a>
  </table>
</template>

<script>
import axios from 'axios'
export default {
  name: 'add_task',
  data() {
    return {
      name: '',
      assignee_id: null,
      is_finished: false,
      tasks: null
    }
  },
  methods: {
    async createTask() {
      try {
        await axios.post('/api/tasks', {
          task: {
            name: this.name,
            is_finished: this.is_finished,
            assignee_id: this.assignee_id
          }
        })
        window.location.href = '/tasks';
      }
      catch (e) {
      }
    }
  },
  async mounted() {
    try {
      const resp = await axios.get('/api/tasks')
      this.tasks = resp.data.tasks
    }
    catch (e) {
    }
  }
}
</script>

