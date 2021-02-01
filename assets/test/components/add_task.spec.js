import { shallowMount } from '@vue/test-utils'
import _ from 'lodash'
import add_task from  '@/src/components/add_task.vue'

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new  MockAdapter(axios);

global.window = Object.create(window);
const pathname = '/tasks/new';

Object.defineProperty(window, 'location', {
  value: {
    pathname,
    href: `http://localhost:4001${ pathname }`
  }
});

describe('add_task.vue', () => {
  const wrapper = shallowMount(add_task);
  const vm = wrapper.vm
  
  it('renders entire component correctly', () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe('createTask', () => {
    it('redirect to /tasks', async () => {  
      mock.onPost("/api/tasks", {task: {name: 'Test', is_finished: false, assignee_id: 1}}).reply(200);
      await wrapper.setData({name: 'Test', is_finished: false, assignee_id: 1})
        
      await vm.createTask()

      expect(window.location.href).toEqual('/tasks');
    });
  });

  it('show validate error messages', async () => {
    mock.onPost("/api/tasks", {task: {name: '', is_finished: false, assignee_id: 1}}).reply(404);
    await wrapper.setData({name: '', is_finished: false, assignee_id: 1});

    const createButton = wrapper.find('button');
    await createButton.trigger('click');

    expect(wrapper.find('p').element).toMatchSnapshot();
  });
});
