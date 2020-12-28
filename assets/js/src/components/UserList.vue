<!-- basement code for the listing user page -->
<template>
  <table>
    <h2>Listing Users</h2>
    <user-detail></user-detail>
    <a href="/users/new" class="button">Add New User</a>
    <a href="/tasks" class="button">Task</a>
    <task-list></task-list>
  </table>
</template>

<script>
import UserDetail from './UserDetail'
import TaskList from './TaskList'
export default {
  components: { UserDetail, TaskList },
  name: 'userList',
  data() {
    return {
      users: null
    }
  },
  mounted() {
    axios
      .get('/api/users')
      .then(response => (this.users = response.data.data))
      .catch(error => console.log(error))
  }
}

</script>
