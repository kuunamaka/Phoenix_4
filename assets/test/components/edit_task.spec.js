import { shallowMount } from "@vue/test-utils";
import edit_task from "@/src/components/edit_task.vue";

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

describe("edit_task.vue", () => {
  const wrapper = shallowMount(edit_task);
  const vm = wrapper.vm;

  it("renders entire component correctly", () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe("updateTask()", () => {
    it("redirect to /tasks", async () => {
      mock.onPut("/api/tasks/1").reply(200, {
        task: {
          id: 1,
          name: "updateTest",
          is_finished: false,
          assignee_id: 1,
        },
      });
      await wrapper.setData({
        id: 1,
        name: "updateTest",
        is_finished: false,
        assignee_id: 1,
      });

      await vm.updateTask({
        id: 1,
        name: "updateTest",
        is_finished: false,
        assignee_id: 1,
      });

      expect(window.location.href).toEqual("/tasks");
    });

    it("show validate error messages", async () => {
      mock
        .onPut("/api/tasks/1", {
          task: { id: 1, name: "", is_finished: false, assignee_id: 1 },
        })
        .reply(404);
      await wrapper.setData({
        id: 1,
        name: "",
        is_finished: false,
        assignee_id: 1,
      });

      const updateButton = wrapper.find("button");
      await updateButton.trigger("click");

      expect(wrapper.find("p").element).toMatchSnapshot();
    });
  });
});
