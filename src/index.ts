import { Elm } from "./elm/Main.elm";
import * as TaskPorts from "./taskports";
import * as Logger from "./ts/logger";

TaskPorts.install();

const program = Elm.Main.init({
  flags: { argv: process.argv, versionMessage: "1.0.0" },
});

program.ports.printAndExitFailure.subscribe((message) => {
  Logger.error(message);
  process.exit(1);
});

program.ports.printAndExitSuccess.subscribe((message) => {
  console.log(message);
  process.exit(0);
});
