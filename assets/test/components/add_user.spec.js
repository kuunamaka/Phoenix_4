import { shallowMount } from '@vue/test-utils'
import _ from 'lodash'
import add_user from  '@/src/components/add_user.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

global.window = Object.create(window);
const pathname = '/users/new';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('add_user.vue', () => {
  const wrapper = shallowMount(add_user);
  const vm = wrapper.vm
  
  it('is a Vue instance', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe('createUser', () => {
    it('redirect to /users', async () => {  
      mock.onPost("/api/users", {user: {name: "Test", username: "testtest"}}).reply(200);
      await wrapper.setData({name: "Test", username: "testtest"})
        
      await vm.createUser()    

      expect(window.location.href).toEqual('/users');
    });
  });
});