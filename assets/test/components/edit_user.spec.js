import { shallowMount } from '@vue/test-utils'
import edit_user from  '@/src/components/edit_user.vue'

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

describe('edit_user.vue', () => {
  const wrapper = shallowMount(edit_user);
  const vm = wrapper.vm
  
  it('renders entire component correctly', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe('updateUser()', () => {
    it('redirect to /users', async () => { 
      mock.onPut('/api/users/1').reply(200, {user: {id: 1, name: 'newTest', username: 'newtesttest'}});
      await wrapper.setData({id: 1, name: 'newTest', username: 'newtesttest'})

      await vm.updateUser({id: 1, name: 'newTest', username: 'newtesttest'})

      expect(window.location.href).toEqual('/users');
    });

    it('show validate error messages', async () => {
      mock.onPut("/api/users/1", {user: {id: 1, name: '', username: ''}}).reply(404);
      await wrapper.setData({id: 1, name: '', username: ''});
  
      const updateButton = wrapper.find('button');
      await updateButton.trigger('click');
  
      expect(wrapper.find('p').element).toMatchSnapshot();
    });
  })
})
