<template>
  <table>
    <h2>Adding Users</h2>
    <p v-if="errors.length">Please correct the following error(s):</p>

    <ul>
      <li v-for="error in errors" :key="error" class="error">{{ error }}</li>
    </ul>
    <div>
      <input v-model="name" name="Name" placeholder="Name" />
      <input v-model="username" name="Username" placeholder="Username" />
    </div>
    <button @click="createUser">Create User</button>
    <a href="/users" class="button">Exit</a>
  </table>
</template>

<script>
import axios from "axios";
export default {
  name: "add_user",
  data() {
    return {
      errors: [],
      name: "",
      username: "",
    };
  },
  methods: {
    async createUser() {
      this.errors = [];
      if (!this.name) {
        this.errors.push("Name required");
      }
      if (!this.username) {
        this.errors.push("Username required");
      }
      if (this.errors.length !== 0) {
        return;
      }
      await axios.post("/api/users", {
        user: {
          name: this.name,
          username: this.username,
        },
      });
      window.location.href = "/users";
    },
  },
};
</script>

<style lang="css">
.error {
  color: crimson;
}
</style>
