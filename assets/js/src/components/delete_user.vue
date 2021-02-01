<template>
  <button class="delete" @click="deleteUser(user)">Delete</button>
</template>

<script>
import axios from "axios";
export default {
  name: "delete_user",
  data() {
    return {
      user: "",
    };
  },
  methods: {
    async deleteUser(user) {
      await axios.delete(`/api/users/${user.id}`, {
        user: {
          name: user.name,
          username: user.username,
        },
      });
      window.location.href = "/users";
    },
  },
  async mounted() {
    const user_id = window.location.pathname.split("/")[2];
    const resp = await axios.get(`/api/users/${user_id}`);
    this.user = resp.data;
  },
};
</script>
