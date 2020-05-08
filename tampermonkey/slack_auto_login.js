// ==UserScript==
// @name         slack auto login
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       404pilot
// @match        https://rackspace.slack.com/?redir=%2Fssb%2Fsignin_redirect
// @grant        GM_openInTab
// @grant        window.close
// @require      http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// @require      https://gist.github.com/raw/2625891/waitForKeyElements.js
// ==/UserScript==

(function() {
  'use strict';

  let loginButtonSelector = "#index_saml_sign_in_with_saml"
  let loginButtonId = "index_saml_sign_in_with_saml"

  waitForKeyElements(loginButtonSelector, login)

  function login() {
    console.log("Automatically logining")

    let loginUrl = document.getElementById(loginButtonId).href

    GM_openInTab(loginUrl, true);

    window.close()
  }
})();
