<!-- listing all users --> <!-- and feature for deleting user -->
<template>
  <table>
    <h2>Listing Users</h2>
    <div v-for="user in orderedUsers" :key="user.id">
      id: <b>{{ user.id }}</b>,
      name: <b>{{ user.name }}</b>,
      username: <b>{{ user.username }}</b>
      <a :href="`/users/${ user.id }`" class="button">Edit User</a>
      <button @click="deleteUser(user)">Delete User</button>
    </div>
    <a href="/users/new" class="button">Add New User</a>
    <a href="/tasks" class="button">Task</a>
  </table>
</template>

<script>
import _ from 'lodash'
export default {
  name: 'userList',
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
  methods: {
    deleteUser(user) {
      axios.delete(`/api/users` + `/${ user.id }`, {
        headers: { 'x-csrf-token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
        user: {
          name: this.name,
          username: this.username
        }
      })
      .then(function (response) {
        alert("User deleted successfully")
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
