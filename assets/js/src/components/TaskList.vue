<!-- basement code for the listing task -->
<template>
  <table>
    <h2>Listing Tasks</h2>
    <script src="https://kit.fontawesome.com/d9f1380ea4.js" crossorigin="anonymous"></script>
    <div
      v-for="task in tasks" :key="task.id"> 
      id: <b>{{ task.id }}</b>,
      name: <b>{{ task.name }}</b>,
      assigned by: <b>{{ task.assignee }}</b>,
      finished_at: <b>{{ task.finished_at }}</b>,
      is_finished: <b>{{ task.is_finished }}</b>,
      Likes: <b>{{ task.favorited_task }}</b>
      <!-- ここにいいねのマークつけること -->
    </div>
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
    console.log("aaa")
    axios
      .get('/api/tasks')
      .then(response => (this.tasks = response.data.data))
      .catch(error => console.log(error))
  }
}

</script>
