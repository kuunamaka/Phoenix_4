<template>
  <table>
    <h2>Listing Users</h2>
    <li v-for="user in orderedUsers" :key="user.id">
      id: <b>{{ user.id }}</b>,
      name: <b>{{ user.name }}</b>,
      username: <b>{{ user.username }}</b>
      <a :href="`/users/${ user.id }`" class="button">Edit</a>
    </li>
    <a href="/users/new" class="button">Add User</a>
    <a href="/tasks" class="button">Task</a>
  </table>
</template>

<script>
import _ from 'lodash'
import axios from 'axios'
export default {
  name: 'user_list',
  data() {
    return {
      name: '',
      username: '',
      users: null
    }
  },
  computed: {
    orderedUsers: function() {
      return _.orderBy(this.users, 'id')
    }
  },
  async mounted() {
    const resp = await axios.get('/api/users')
    this.users = resp.data.users
  }
}
</script>
