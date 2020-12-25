<template>
    <div>
      <h1>{{ text }}</h1>
      <user-list></user-list> <!-- just displaying -->
    </div>
</template>

<script>
import UserList from './components/UserList'

export default {
   name: 'app',
   props: {
       text: {
           type: String,
           default: 'TodoTutorial Application'
       }
   },
   components: {
     UserList
   }
}
</script>

<style>
  .button {
  }
</style>
