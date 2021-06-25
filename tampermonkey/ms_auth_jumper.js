// ==UserScript==
// @name         MS Auth Jumper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://login.microsoftonline.com/*/saml2?SAMLRequest=*
// @icon         https://www.google.com/s2/favicons?domain=microsoftonline.com
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// @require      https://gist.github.com/raw/2625891/waitForKeyElements.js
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  let emailSelector = "[aria-label*='ning']";
  let passwordSelector = "[name='passwd']";

  function clickSignIn() {
    console.log("Clicking sign-in button...")

    let signInButton = $("#idSIButton9")[0]

    signInButton.click()
  }

  function clickEmail() {
    console.log("Clicking email...")

    let emailButton = $(emailSelector)[0]

    emailButton.click()
  }

  function passwordLoader() {
    console.log("Waiting for the password to be filled...")

    let password = $(passwordSelector)[0]

    setTimeout(clickSignIn, 2000);
  }

  waitForKeyElements(passwordSelector, passwordLoader);
  waitForKeyElements(emailSelector, clickEmail);
})();
