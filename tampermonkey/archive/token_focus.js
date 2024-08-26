// ==UserScript==
// @name         Token Focus
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://rackspace.auth.securid.com/oidc-fe/auth
// @icon         https://www.google.com/s2/favicons?domain=microsoftonline.com
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// @require      https://gist.github.com/raw/2625891/waitForKeyElements.js
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  let tokenSelector = "#input_otp_secret";
  let tokenId = "input_otp_secret";

  function focusToken() {
    console.log("Focusing token input...");
    setTimeout(helper, 2000);
  };

  function helper() {
    // let tokenSelector = $(tokenSelector)[0]
    // tokenSelector.focus()

    document.getElementById(tokenId).focus();
    document.getElementById(tokenId).scrollIntoView();
  }

  waitForKeyElements(tokenSelector, focusToken);
})();
