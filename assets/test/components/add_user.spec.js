import { shallowMount } from "@vue/test-utils";
import _ from "lodash";
import add_user from "@/src/components/add_user.vue";

const axios = require("axios");
const MockAdapter = require("axios-mock-adapter");
const mock = new MockAdapter(axios);

global.window = Object.create(window);
const pathname = "/users/new";

Object.defineProperty(window, "location", {
  value: {
    pathname,
    href: `http://localhost:4001${pathname}`,
  },
});

describe("add_user.vue", () => {
  const wrapper = shallowMount(add_user);
  const vm = wrapper.vm;

  it("renders entire component correctly", () => {
    expect(wrapper.element).toMatchSnapshot();
  });

  describe("createUser", () => {
    it("redirect to /users", async () => {
      mock
        .onPost("/api/users", { user: { name: "Test", username: "testtest" } })
        .reply(200);
      await wrapper.setData({ name: "Test", username: "testtest" });

      await vm.createUser();

      expect(window.location.href).toEqual("/users");
    });

    it("show validate error messages", async () => {
      mock
        .onPost("/api/users", { user: { name: "", username: "" } })
        .reply(404);
      await wrapper.setData({ name: "", username: "" });

      const createButton = wrapper.find("button");
      await createButton.trigger("click");

      expect(wrapper.find("p").element).toMatchSnapshot();
    });
  });
});
