<template>
  <div>
    {{ title }}
    <UserList />
  </div>
</template>

<script>
import UserList from './components/UserList.vue'

export default {
  name: 'app',
  components: {
    UserList
  },
  props: {
    title: {
      type: String,
      default: 'Listing Users'
    }
  }
}
</script>
