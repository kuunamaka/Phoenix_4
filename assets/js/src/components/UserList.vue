<!-- basement code for the listing user page -->
<template>
   <table>
    <p>inside of UserList component!</p>
  </table>
</template>

<script>
export default {
  name: 'userList',
  mounted() {
    console.log("aaa")
   
    const iti =  axios.get('/api/users').then(function(response){
        console.log(response);
      });

    console.log(iti)
        console.log("ccccc")

  },
}

</script>
