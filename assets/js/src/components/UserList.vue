<!-- basement code for the listing user page -->
<template>
   <table>
    <p>inside of UserList component!</p>  
    <h2>{{ users.id }}</h2>
    <pre>{{ users.name }}</pre>
  </table>
</template>

<script>
export default {
  name: 'userList'
}
var vm = new Vue({
  el: '#app',
  data: {
    users: []
  },
  created: function(){
    axios.get('/users').then(function(response){
      app.users = response.data.data;
    })
  }
})
</script>
