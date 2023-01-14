import * as TaskPort from "elm-taskport/js/taskport.js";
import * as Logger from "./ts/logger";
import * as Env from "./ts/env";
import xhr from "xhr2";

export function install() {
  installElmTaskport();
  Env.register();
  Logger.register();
}

function installElmTaskport() {
  global.XMLHttpRequest = xhr;
  global.ProgressEvent = xhr.ProgressEvent;

  TaskPort.install({ logErrors: false }, undefined);
}
