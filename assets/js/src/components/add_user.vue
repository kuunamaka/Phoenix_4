<!-- adding a new user page -->
<template>
  <table>
    <h2>Adding Users</h2>
    <div>
      <input v-model="name" placeholder="Name">
      <input v-model="username" placeholder="Username">
    </div>
    <button @click="createUser">Create User</button>
    <a href="/users" class="button">Exit</a>
  </table>
</template>

<script>
import axios from 'axios'
export default {
  name: 'add_user',
  data() {
    return {
      name: '',
      username: ''
    }
  },
  methods: {
    async createUser() {
      try {
        const resp = await axios.post('/api/users', {
          user: {
            name: this.name,
            username: this.username
          }
        })
        console.log(resp);
        window.location.href = '/users';
      }
      catch (e) {
        console.log(e)
      }
    }
  }
}
</script>
