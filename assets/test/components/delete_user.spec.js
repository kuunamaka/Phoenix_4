import { shallowMount } from '@vue/test-utils'
import delete_user from  '@/src/components/delete_user.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

mock.onGet("/api/users/1").reply(200, {
    id: 1, name: "Test", username: "testtest"}
);

global.window = Object.create(window);
const pathname = '/users/1';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('delete_user.vue', () => {
  const wrapper = shallowMount(delete_user);
  const vm = wrapper.vm
    
  it('is a Vue instance', () => {
    expect(wrapper.element).toMatchSnapshot();
  });
  
  describe('deleteUser()', () => {
    it('redirect to /users', async () => { 
      mock.onDelete('/api/users/1').reply(200, {user: {id: 1, name: 'Test', username: 'testtest'}});
      await wrapper.setData({user: {id: 1, name: 'Test', username: 'testtest'}})
  
      await vm.deleteUser({id: 1, name: 'Test', username: 'testtest'})
  
      expect(window.location.href).toEqual('/users');
    });
  })
})
