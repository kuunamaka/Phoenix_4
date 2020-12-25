import Vue from 'vue'
import App from './App.vue'
import UserList from './components/UserList'
import UserDetail from './components/UserDetail'
import AddUser from './components/AddUser'
import TaskList from './components/TaskList'

new Vue({
  el: '#app',
  components: {
    UserList,
    UserDetail,
    AddUser,
    TaskList
  }
});
