<template>
  <table>
    <h2>Adding Users</h2>
    <div v-for="user in users" :key="user.id">
      <input v-model="name" placeholder="Name">
      <input v-model="username" placeholder="Username">
    </div>
    <a href="/users" class="button">Create User</a> <!-- 作成したuser(DBに繋げる) -->
    <a href="/users" class="button">Back to User list</a>
  </table>
</template>

<script>
export default {
  name: 'userDetail',
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
