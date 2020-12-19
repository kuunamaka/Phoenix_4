<template>
    <div class="body">
      {{ text }}
      <user-list />
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
