<template>
  <table v-if="task">
    <h2>Task Details</h2>
    <div>
      <b>Task:</b> {{ task.name }}
      (by: <b>{{ task.assignee }}</b>)
    </div>  
    <div>
      <b>Is_finished?:</b> {{ task.is_finished }},
      <b>finished_at:</b> {{ task.finished_at }},
      <button
        v-if="task.is_liked"
        @click="deleteLike(task)"
        class="fas fa-heart"
      ></button>
      <button v-else @click="createLike(task)" class="far fa-heart"></button>
      <b>{{ task.favorited_users.length }}</b>
    </div>
    <!-- <div>
      <input v-model="comment" type="text" />
      <button @click="createComment">Add Comment</button>
    </div> -->
    <a href="/tasks" class="button">Exit</a>
  </table>
</template>

<script>
import _ from "lodash";
import axios from "axios";
export default {
  data() {
    return {
      task: null,
      comemnt: ""
    };
  },
  methods: {
    async createLike(task) {
      await axios.post(`/api/tasks/${task.id}/users`, {
        task: {
          name: this.name,
          id: this.id,
        },
      });
      window.location.href = `/tasks/${task.id}`;
    },
    async deleteLike(task) {
      await axios.delete(`/api/tasks/${task.id}/users/1`, {
        task: {
          name: this.name,
          id: this.id,
        },
      });
      window.location.href = `/tasks/${task.id}`;
    },
    // async createComment() {
    //   await axios.post(`/api/tasks/${task.id}/comments/new`, {
    //     task: {
    //     },
    //   });
    //   window.location.href = "/tasks";
    // },
  },
  async mounted() {
    const task_id = window.location.pathname.split("/")[2];
    const resp = await axios.get(`/api/tasks/${task_id}`);
    this.task = resp.data;
  },
};
</script>
