// JS Goes here - ES6 supported

import "./scss/main.scss";
import * as common from "./common.js";

function redirectToAragon() {
  const progress = document.getElementById("progress");
  progress.style.transition = 'width 10s linear';
  progress.style.width = '0%';
  // TODO: add debug flag to disable redirection
  setTimeout((() => window.location.href = 'https://mainnet.aragon.org/#/notadao'), 10000);
}

common.ready(redirectToAragon);
