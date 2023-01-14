import * as TaskPort from "elm-taskport/js/taskport.js";

export function register() {
  TaskPort.register("getEnv", (name) => {
    return process.env[name];
  });
}
