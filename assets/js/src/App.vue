<template>
    <div>
      {{ text }}
    </div>
</template>

<script>
export default {
   name: 'app',
   props: {
       text: {
           type: String,
           default: 'Hello, Vue.js!'
       }
   }
}
</script>
