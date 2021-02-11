import { shallowMount } from "@vue/test-utils";
import task_detail from "@/src/components/task_detail.vue";

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new MockAdapter(axios);

mock.onGet("/api/tasks/1").reply(200, {
  id: 1,
  name: "Test",
  is_finished: false,
  assignee_id: 1,
});

window = Object.create(window);
const pathname = "/tasks/1";

Object.defineProperty(window, "location", {
  value: {
    pathname,
    href: `http://localhost:4001${pathname}`,
  },
});

describe("task_detail.vue", () => {
  const wrapper = shallowMount(task_detail);
  const vm = wrapper.vm;

  it("renders entire component correctly", () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe("createLike/1", () => {
    it("redirect to /tasks/${task.id}", async () => {
      mock
        .onPost("/api/tasks/1/users", { task: { id: 1, name: "Test" } })
        .reply(200);
      await wrapper.setData({ id: 1, name: "Test" });

      await vm.createLike({ id: 1, name: "Test" });

      expect(window.location.href).toEqual("/tasks/1");
    });
  });

  describe("deleteLike/1", () => {
    it("redirect to /tasks/${task.id}", async () => {
      mock
        .onDelete("/api/tasks/1/users/1", { task: { id: 1, name: "Test" } })
        .reply(200);
      await wrapper.setData({ id: 1, name: "Test" });

      await vm.deleteLike({ id: 1, name: "Test" });

      expect(window.location.href).toEqual("/tasks/1");
    });
  });

  describe("createComment", () => {
    it("redirect to /tasks/${task.id}", async () => {
      mock
        .onPost("/api/tasks/1/comments", {
          comment: {
            body: "Test Comment",
            task_id: 1
          }
        })
        .reply(200);
      await wrapper.setData({ body: "Test Comment", task_id: 1 });
      
      await vm.createComment({ body: "Test Comment", task_id: 1 });

      expect(window.location.href).toEqual("/tasks/1");
    });

    it("show validate error messages", async () => {
      mock
        .onPost("/api/tasks/1/comments", {
          comment: {
            body: "Test Comment",
            task_id: 1,
          },
        })
        .reply(404);
      await wrapper.setData({ body: "", task_id: 1 });
  
      await vm.createComment();
  
      expect(wrapper.find("p").element).toMatchSnapshot();
    });
  });
});
