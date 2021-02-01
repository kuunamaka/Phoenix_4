import { shallowMount } from '@vue/test-utils'
import _ from 'lodash'
import task_list from  '@/src/components/task_list.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

mock.onGet("/api/tasks").reply(200, {
  tasks: [
    {id: 1, name: "Test", assignee: "Assignee", is_finished: false, is_liked: false, assignee_id: 2},
    {id: 2, name: "Assignee", assignee: "Test", is_finished: false, is_liked: false, assignee_id: 1}
  ]
});

window = Object.create(window);
const pathname = '/tasks';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('task_list.vue', () => {
  const wrapper = shallowMount(task_list);
  const vm = wrapper.vm

  it('renders entire component correctly', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  it('order tasks by their id', () => {
    const expectTasks = [
      {id: 1, name: "Test", assignee: "Assignee", is_finished: false, is_liked: false, assignee_id: 2},
      {id: 2, name: "Assignee", assignee: "Test", is_finished: false, is_liked: false, assignee_id: 1}
    ];
    expect(vm.tasks).toEqual(expectTasks)
  })

  describe('createLike/1', () => {
    it('redirect to /tasks', async () => {  
      mock.onPost("/api/tasks/1/users", {task: {id: 1, name: 'Test'}}).reply(200);
      await wrapper.setData({id: 1, name: 'Test'})
        
      await vm.createLike({id: 1, name: 'Test'})

      expect(window.location.href).toEqual('/tasks');
    });
  });

  describe('deleteLike/1', () => {
    it('redirect to /tasks', async () => {  
      mock.onDelete("/api/tasks/1/users/1", {task: {id: 1, name: 'Test'}}).reply(200);
      await wrapper.setData({id: 1, name: 'Test'})
        
      await vm.deleteLike({id: 1, name: 'Test'})

      expect(window.location.href).toEqual('/tasks');
    });
  });
});
