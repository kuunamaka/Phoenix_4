<!-- adding a new task -->
<template>
  <table>
    <h2>Adding Task</h2>
    <div>
      <div>
        Name
        <input v-model="task_name">
      </div>
      <div>
        Assigned by:
        <select v-model="selected">
          <option disabled>Please select one</option>
          <option v-for="task in tasks" :key="task.id">
            {{ task.assignee_id }} <!-- && task.assignee }} -->
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
export default {
  name: 'addTask',
  data() {
    return {
      task_name: '',
      selected: '',
      is_finished: false,
      tasks: null
    }
  },
  methods: {
    createTask() {
      axios.post('/api/tasks', {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        task: {
          name: this.task_name,
          is_finished: this.is_finished,
          assignee_id: this.selected
        }
      })
      .then(function (response) {
        alert("Task created successfully")
        console.log(response);
        window.location.href = 'http://localhost:4001/tasks';
      })
      .catch(function (error) {
        alert("Couldn't create it, please try again.")
        console.log(error);
      });
    }
  },
  mounted() {
    axios
      .get('/api/tasks')
      .then(response => (this.tasks = response.data.data))
      .catch(error => console.log(error))
  }
}
</script>

