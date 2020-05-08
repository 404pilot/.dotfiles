// ==UserScript==
// @name         auth jumper
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       404pilot
// @match        https://sts.rackspace.com/adfs/ls/*
// @grant        none
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// @require      https://gist.github.com/raw/2625891/waitForKeyElements.js
// ==/UserScript==

(function () {
  'use strict';
  let loginSelector = "#submitButton";
  let loginId = "submitButton";
  let authOptionSelector = "#SecurIDAuthentication";
  let authOptionId = "SecurIDAuthentication";
  let passcodeSelector = '#passcodeInput';
  let passcodeId = 'passcodeInput';

  waitForKeyElements(loginSelector, loginButton)
  waitForKeyElements(authOptionSelector, clickButton)
  waitForKeyElements(passcodeSelector, focusInput)


  function loginButton() {
    if (document.getElementById("formsAuthenticationArea") != undefined) {
      console.log("Trying to click the login button");

      const test_val = document.getElementById("passwordInput").value;

      console.log("value:", test_val)
      console.log("value type:", typeof test_val)

      while (document.getElementById("passwordInput").value === "") {
        console.log("Waiting for lastpass to fill out password");

        setTimeout(loginButton, 1000);
        return
      }

      console.log("Clicking username/password login button...");


      document.getElementById(loginId).click()
    } else {
      console.log("This is not the login page to login with username/password");
    }
  }

  function clickButton() {
    console.log("Clicking SecureId auth button...");

    document.getElementById(authOptionId).click();
  }


  function focusInput() {
    console.log("focusing");

    let passcode = document.getElementById(passcodeId);

    passcode.setAttribute("tabindex", -1);
    passcode.focus()
  }
})();
