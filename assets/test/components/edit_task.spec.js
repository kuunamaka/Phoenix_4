import { shallowMount } from '@vue/test-utils'
import edit_task from  '@/src/components/edit_task.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

mock.onGet("/api/tasks/1").reply(200, {
  id: 1, name: "Test", is_finished: false, assignee_id: 1}
);
axios.get("/api/tasks/1").then(function(response) {
  console.log(response.data)
});

global.window = Object.create(window);
const pathname = '/tasks/1';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('edit_task.vue', () => {
  const wrapper = shallowMount(edit_task);
  const vm = wrapper.vm
  
  it('is a Vue instance', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe('updateTask()', () => {
    it('redirect to /tasks', async () => { 
      mock.onPut('/api/tasks/1').reply(200, {task: {id: 1, name: 'updateTest', is_finished: false, assignee_id: 1}});
      await wrapper.setData({id: 1, name: 'updateTest', is_finished: false, assignee_id: 1})

      await vm.updateTask({id: 1, name: 'updateTest', is_finished: false, assignee_id: 1})

      expect(window.location.href).toEqual('/tasks');
    });
  })
})