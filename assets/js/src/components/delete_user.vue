<template>
  <button class="delete" @click="deleteUser(user)">Delete</button>
</template>

<script>
import axios from 'axios'
export default {
  name: 'delete_user',
  data() {
    return{
      user: ''
    }
  },
  methods: {
    async deleteUser(user) {
      try {
        const resp = await axios.delete(`/api/users` + `/${ user.id }`, {
          user: {
            name: user.name,
            username: user.username
          }
        })
        console.log(resp);
        window.location.href = '/users';
      }
      catch (e) {
        console.log(e)
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
      console.log(e)
    }
  }
}
</script>
