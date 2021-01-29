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
      try {
        const resp = await axios.delete(`/api/tasks` + `/${ task.id }`, {
          task: {
            name: this.name
          }
        })
        console.log(resp);
        window.location.href = '/tasks';
      }
      catch (e) {
        console.log(e)
      }
    }
  },
  async mounted() {
    try {
      const task_id = window.location.pathname.split('/')[2];
      const resp = await axios.get('/api' + `/tasks/${ task_id }`)
      this.task = resp.data
    }
    catch (e) {
      console.log(e)
    }
  }
}
</script>
