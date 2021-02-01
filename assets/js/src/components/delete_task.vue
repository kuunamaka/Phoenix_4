<template>
  <div><button @click="deleteTask(task)">Delete</button></div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'delete_task',
  data() {
    return {
      task: ''
    }
  },
  methods: {
    async deleteTask(task) {
      await axios.delete(`/api/tasks` + `/${ task.id }`, {
        task: {
          name: this.name
        }
      })
      window.location.href = '/tasks';
    }
  },
  async mounted() {
    const task_id = window.location.pathname.split('/')[2];
    const resp = await axios.get('/api' + `/tasks/${ task_id }`)
    this.task = resp.data
  }
}
</script>
