<!-- basement code for the listing task -->
<template>
  <table>
    <h2>Listing Tasks</h2>
    <div
      v-for="task in tasks" :key="task.id"> 
      name: <b>{{ task.name }}</b>,
      finished_at: <b>{{ task.finished_at }}</b>,
      is_finished: <b>{{ task.is_finished }}</b>

    </div>
<!--    <user-detail></user-detail>   -->
  </table>
</template>

<script>
export default {
  name: 'taskList',
  data() {
    return {
      tasks: null
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
