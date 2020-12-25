<!-- basement code for the listing user page -->
<template>
  <table>
    <h2>Listing Users</h2>
    <div
      v-for="user in users" :key="user.id">
      name: <b>{{ user.name }}</b>
      <a :href="`/users` + `/${user.id}`" class="button">See User</a>
    </div>
    <a href="/users/new" class="button">Add New User</a>
    <a href="/tasks" class="button">Task</a>
  </table>
</template>

<script>
import UserDetail from './UserDetail.vue'
export default {
  components: { UserDetail },
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
