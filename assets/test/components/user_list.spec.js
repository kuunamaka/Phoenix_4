import { shallowMount } from '@vue/test-utils'
import _ from 'lodash'
import user_list from  '@/src/components/user_list.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

mock.onGet("/api/users").reply(200, {
  users: [
    {id: 1, name: "Maui", username: "Kuunamaka"},
    {id: 2, name: "Tasuku", username: "Kaleorani"}
  ]
});
axios.get("/api/users").then(function(response) {
  console.log(response.data.users)
});

window = Object.create(window);
const pathname = '/users';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('user_list.vue', () => {
  const wrapper = shallowMount(user_list);

  it('is a Vue instance', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  it('order users by their id', () => {
    const expectUsers = [
      {id: 1, name: "Maui", username: "Kuunamaka"},
      {id: 2, name: "Tasuku", username: "Kaleorani"}
    ];
    const vm = wrapper.vm

    expect(vm.users).toEqual(expectUsers)
  })
});
