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
import api from '../api';
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
          name: { name: this.name },
          username: { username: this.username }
        }
        // ,
        // data: {
        //   name: this.name ,
        //   username: this.username 
        // }
        // ここわかんない
        // name: { name: this.name },
        // username: { username: this.username }
        // どっちでやってもエラー出る
      })
      .then(function (response) {
        console.log(response);
      })
      .catch(function (error) {
        console.log(error);
      })
      .finally(function() {
        // always excecuted
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
