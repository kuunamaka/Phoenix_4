<template>
  <table>
    <h2>Showing Users</h2>
    <div v-for="user in users" :key="user.id">
      id: <b>{{ user.id }}</b>,
      name: <b>{{ user.name }}</b>,
      username: <b>{{ user.username }}</b>
    </div>
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
