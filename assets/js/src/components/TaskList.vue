<!-- listing all tasks -->
<template>
  <table>
    <h2>Listing Tasks</h2>
    <div v-for="task in orderedTasks" :key="task.id"> 
      id: <b>{{ task.id }}</b>,
      name: <b>{{ task.name }}</b>,
      assigned by: <b>{{ task.assignee }}</b>,
      finished_at: <b>{{ task.finished_at }}</b>,
      is_finished: <b>{{ task.is_finished }}</b>,
      Likes: <b>{{ task.favorited_task }}</b>
      <!-- place the icon of likes -->
    </div>
  </table>
</template>

<script>
import _ from 'lodash'
export default {
  name: 'taskList',
  data() {
    return {
      tasks: []
    }
  },
  computed: {
    orderedTasks: function() {
      return _.orderBy(this.tasks, 'id')
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
