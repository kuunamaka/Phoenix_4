<template>
  <table v-if="task">
    <h2>Task Details</h2>
    <div>
      <b>Task:</b> {{ task.name }} (by: <b>{{ task.assignee }}</b
      >)
    </div>
    <div>
      <b>Is_finished?:</b> {{ task.is_finished }}, <b>finished_at:</b>
      {{ task.finished_at }},
      <button
        v-if="task.is_liked"
        @click="deleteLike(task)"
        class="fas fa-heart"
      ></button>
      <button v-else @click="createLike(task)" class="far fa-heart"></button>
      <b>{{ task.favorited_users.length }}</b>
    </div>
    <div v-if="errors.length">
      <p v-for="error in errors" :key="error" class="error">{{ error }}</p>
    </div>
    <div>
      Comment: <b>{{ task.comment }}</b>
    </div>
    <div>
      <input v-model="comment" type="text" />
      <button @click="createComment(comment)" class = "comment">Add Comment</button>
    </div>
    <a href="/tasks" class="button">Exit</a>
  </table>
</template>

<script>
import axios from "axios";
export default {
  name: "task_detail",
  data() {
    return {
      task: null,
      comment: null,
      errors: [],
    };
  },
  methods: {
    async createLike(task) {
      await axios.post(`/api/tasks/${this.task.id}/users`, {
        task: {
          name: this.name,
          id: this.task.id,
        },
      });
      window.location.href = `/tasks/${this.task.id}`;
    },
    async deleteLike(task) {
      await axios.delete(`/api/tasks/${this.task.id}/users/1`, {
        task: {
          name: this.name,
          id: this.task.id,
        },
      });
      window.location.href = `/tasks/${this.task.id}`;
    },
    async createComment(comment) {
      this.errors = [];
      if (!this.comment) {
        this.errors.push("Comments cannot be blank");
      }
      if (this.errors.length !== 0) {
        return;
      }
      await axios.post(`/api/tasks/${this.task.id}/comments`, {
        comment: {
          body: this.comment,
          task_id: this.task.id,
        }
      });
      window.location.href = `/tasks/${this.task.id}`;
    },
  },
  async mounted() {
    const task_id = window.location.pathname.split("/")[2];
    const resp = await axios.get(`/api/tasks/${task_id}`);
    this.task = resp.data;
  },
};
</script>
