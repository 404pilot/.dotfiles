// ==UserScript==
// @name         slack login trigger
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        http://127.0.0.1:29001/saml
// @grant        GM_openInTab
// ==/UserScript==

(function() {
  'use strict';

  GM_openInTab("https://rackspace.slack.com/ssb/signin_redirect", true);
})();
