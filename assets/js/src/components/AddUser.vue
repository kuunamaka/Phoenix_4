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
export default {
  name: 'addUser',
  data() {
    return {
      name: '',
      username: ''
    }
  },
  methods: {
    createUser() {
      axios.post('/api/users', {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        user: {
          name: this.name,
          username: this.username
        }
      })
      .then(function (response) {
        alert("User created successfully")
        console.log(response);
        window.location.href = 'http://localhost:4001/users';
      })
      .catch(function (error) {
        alert("Couldn't created user, please try again.")
        console.log(error);
      });
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
