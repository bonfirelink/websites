// JS Goes here - ES6 supported

import "./scss/main.scss";
import * as common from "./common.js";

function redirectToAragon() {
  const redirect = document.getElementById("redirect");
  const progress = document.getElementById("progress");
  const transitionDuration = getComputedStyle(progress).transitionDuration;
  const milliseconds = parseInt(transitionDuration.replace('s', '')) * 1000;
  progress.style.width = '0%';
  // TODO: add debug flag to disable redirection
  setTimeout((() => window.location.href = redirect.href), milliseconds);
}

common.ready(redirectToAragon);
