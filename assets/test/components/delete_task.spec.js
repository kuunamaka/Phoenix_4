import { shallowMount } from "@vue/test-utils";
import delete_task from "@/src/components/delete_task.vue";

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new MockAdapter(axios);

mock.onGet("/api/tasks/1").reply(200, {
  id: 1,
  name: "Test",
  is_finished: false,
  assignee_id: 1,
});

global.window = Object.create(window);
const pathname = "/tasks/1";

Object.defineProperty(window, "location", {
  value: {
    pathname,
    href: `http://localhost:4001${pathname}`,
  },
});

describe("delete_task.vue", () => {
  const wrapper = shallowMount(delete_task);
  const vm = wrapper.vm;

  it("renders entire component correctly", () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe("deleteTask()", () => {
    it("redirect to /tasks", async () => {
      mock
        .onDelete("/api/tasks/1")
        .reply(200, { task: { id: 1, name: "Test" } });
      await wrapper.setData({ task: { id: 1, name: "Test" } });

      await vm.deleteTask({ id: 1, name: "Test" });

      expect(window.location.href).toEqual("/tasks");
    });
  });
});
