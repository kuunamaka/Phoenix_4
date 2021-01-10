<!-- updating the user -->
<template>
  <table>
    <div>
      <h3>Updating User</h3>
      <select v-model="users.id">
        <option v-for="user in users" :key="user.id">
          {{ user.id }}
        </option>
      </select>
      <input v-model="name" placeholder="new name">
      <input v-model="username" placeholder="new username">
      <button @click="updateUser(users)">Update User</button>
    </div>
    <a href="/users" class="button">Exit</a>
  </table>
</template>

<script>
export default {
  name: 'userDetail',
  data() {
    return {
      name: '',
      username: '',
      users: []
    }
  },
  methods: {
    updateUser(users) {
      axios.put('/api/users' + `/${ users.id }`, {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        user: {
          name: this.name,
          username: this.username
        }
      })
      .then(function (response) {
        alert("User updated successfully");
        console.log(response);
        window.location.href = 'http://localhost:4001/users';
      })
      .catch(function (error) {
      alert("Couldn't update the user, please try again.");
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
