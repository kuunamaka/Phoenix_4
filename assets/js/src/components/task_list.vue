<!-- listing all tasks --> <!-- and feature for deleting the task -->
<template>
  <table>
    <h2>Listing Tasks</h2>
    <li v-for="task in orderedTasks" :key="task.id"> 
      <b>{{ task.name }}</b> (by: <b>{{ task.assignee }}</b>):
      (finished_at: <b>{{ task.finished_at }}</b>,)
      Is_finished?: <b>{{ task.is_finished }}</b>,
      <button v-if="task.is_liked" @click="deleteLike(task)" class="fas fa-heart"></button>
      <button v-else @click="createLike(task)" class="far fa-heart"></button>
      <b>{{ task.favorited_users.length }}</b>,
      <a :href="`/tasks/${ task.id }/edit`" class="button">Edit</a>
    </li>
    <a href="/tasks/new" class="button">Add task</a>
    <a href="/users" class="button">User</a>
  </table>
</template>

<script>
import _ from 'lodash';
import axios from 'axios';
import edit_task from './edit_task'
export default {
  components: { edit_task },
  name: 'task_list',
  data() {
    return {
      tasks: null,
      name: '',
      id: null
    }
  },
  computed: {
    orderedTasks: function() {
      return _.orderBy(this.tasks, 'id')
    }
  },
  methods: {
    async createLike(task){
      try {
        const resp = await axios.post(`/api/tasks` + `/${ task.id }` + `/users`, {
          task: {
            name: this.name,
            id: this.id
          }
        })
        console.log(resp);
        window.location.href = '/tasks';
      }
      catch (e) {
        console.log(e)
      }
    },
    async deleteLike(task){
      try {
        const resp = await axios.delete(`/api/tasks` + `/${ task.id }` + `/users` + `/1`, {
          task: {
            name: this.name,
            id: this.id
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
      const resp = await axios.get('/api/tasks')
      this.tasks = resp.data.tasks
    } catch (e) {
      console.log(e)
    }
  }
}
</script>

<style lang="css">
/* like */
.fas {
  background-color: #e0245e;
  border-color: #e0245e;
}
/* unlike */
.far {
  background-color: #bbbbbb;
  border-color: #bbbbbb;
}
</style>
