import Vue from 'vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import UserList from './components/UserList'
import UserDetail from './components/UserDetail'
import AddUser from './components/AddUser'
import TaskList from './components/TaskList'

Vue.use(VueAxios, axios)

new Vue({
  el: '#app',
  components: {
    UserList,
    UserDetail,
    AddUser,
    TaskList
  }
});
