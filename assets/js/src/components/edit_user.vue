<template>
  <table>
    <div>
      <h2>Updating User</h2>
      <h4>* User id won't be able to change</h4>
      <p v-if = "errors.length">
        Please correct the following error(s):
        <ul>
          <li v-for = "error in errors" :key="error" class = "error"> {{ error }}</li>
        </ul>
      </p>
      <input v-model="name" placeholder="new name">
      <input v-model="username" placeholder="new username">
    </div>
    <br />
      <button @click="updateUser(user)">Submit</button>
      <a href="/users" class="button">Exit</a>
    <div>
      <delete-user />
    </div>
  </table>
</template>

<script>
import axios from 'axios'
import DeleteUser from './delete_user';
export default {
  name: 'user_detail',
  components: {DeleteUser},
  data() {
    return {
      errors: [],
      name: '',
      username: '',
      user: ''
    }
  },
  methods: {
    async updateUser(user) {
      if (this.name && this.username) {
        await axios.put('/api/users' + `/${ user.id }`, {
          user: {
            name: this.name,
            username: this.username
          }
        })
        window.location.href = '/users';
      }
      
      this.errors = [];

      if (!this.name) {
        this.errors.push("Name required");
      }
      if (!this.username) {
        this.errors.push("Username required");
      }
    }
  },
  async mounted() {
    const user_id = window.location.pathname.split('/')[2];
    const resp = await axios.get('/api' + `/users/${ user_id }`)
    this.user = resp.data
  }
}
</script>
