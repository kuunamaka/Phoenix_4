<!-- updating the user -->
<template>
  <table>
    <div>
      <h2>Updating User</h2>
      <p>* User id won't be able to change</p>
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
      name: '',
      username: '',
      user: ''
    }
  },
  methods: {
    async updateUser(user) {
      try {
        await axios.put('/api/users' + `/${ user.id }`, {
          user: {
            name: this.name,
            username: this.username
          }
        })
        window.location.href = '/users';
      }
      catch (e) {
      }
    }
  },
  async mounted() {
    try {
      const user_id = window.location.pathname.split('/')[2];
      const resp = await axios.get('/api' + `/users/${ user_id }`)
      this.user = resp.data
    }
    catch (e) {
    }
  }
}
</script>
