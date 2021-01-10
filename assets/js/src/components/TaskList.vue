<!-- listing all tasks --> <!-- and feature for deleting the task -->
<template>
  <table>
    <h2>Listing Tasks</h2>
    <li v-for="task in orderedTasks" :key="task.id"> 
      <b>{{ task.name }}</b> (by: <b>{{ task.assignee }}</b>):
      (finished_at: <b>{{ task.finished_at }}</b>,)
      Is_finished?: <b>{{ task.is_finished }}</b>,
      <button v-if="task.is_liked" @click="deleteLike(task, user_id)" class="fas fa-heart"></button>
      <button v-else @click="createLike(task)" class="far fa-heart"></button>
      <b>{{ task.favorited_num }}</b>,
      <button @click="deleteTask(task)">Delete Task</button>
    </li>
    <a href="/tasks/new" class="button">Add task</a>
    <a href="/users" class="button">User</a>
  </table>
</template>

<script>
import _ from 'lodash';
import axios from 'axios';
export default {
  name: 'taskList',
  data() {
    return {
      tasks: null,
      name: '',
      id: ''
    }
  },
  computed: {
    orderedTasks: function() {
      return _.orderBy(this.tasks, 'id')
    }
  },
  methods: {
    deleteTask(task) {
      axios.delete(`/api/tasks` + `/${ task.id }`, {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        task: {
          name: this.name
        }
      })
      .then(function (response) {
        alert("Task deleted successfully")
        console.log(response);
        window.location.href = 'http://localhost:4001/tasks';
      })
      .catch(function (error) {
        alert("Couldn't created user, please try again.")
        console.log(error);
      });
    },
    createLike(task){
      axios.post(`/api/tasks` + `/${ task.id }` + `/users`, {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        task: {
          name: this.name,
          id: this.id
        }
      })
      .then(function (response) {
        alert("Task liked successfully")
        console.log(response);
        window.location.href = 'http://localhost:4001/tasks';
      })
      .catch(function (error) {
        alert("Couldn't liked this task, please try again.")
        console.log(error);
      });
    },
    deleteLike(task, user_id){
      axios.delete(`/api/tasks` + `/${ task.id }` + `/users` + `/1`, {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        task: {
          name: this.name,
          id: this.id
        }
      })
      .then(function (response) {
        alert("Task unliked successfully")
        console.log(response);
        window.location.href = 'http://localhost:4001/tasks';
      })
      .catch(function (error) {
        alert("Couldn't unlike this task, please try again.")
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
