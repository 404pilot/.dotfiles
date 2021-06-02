// ==UserScript==
// @name         aws step functions
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       404pilot
// @match        https://us-west-2.console.aws.amazon.com/states/home?region=us-west-2
// @require      https://gist.github.com/raw/2625891/waitForKeyElements.js
// ==/UserScript==

(function () {
  'use strict';

  let searchBarClassName = "awsui-input awsui-input-type-search"

  let contentSelector = ".awsui-table-row.awsui-table-row-selected"

  waitForKeyElements(contentSelector, addText)

  function addText() {
    console.log("Adding text");

    // input event
    let evt = document.createEvent('HTMLEvents');
    evt.initEvent('input', true, true);

    let searchBar = document.getElementsByClassName(searchBarClassName)[0]

    searchBar.value = "ningzou"
    searchBar.dispatchEvent(evt)
  }

  //let targetNode = document.querySelector("#passcodeInput")
  //--- Simulate a natural mouse-click sequence.
  //triggerMouseEvent(targetNode, "mouseover");
  //triggerMouseEvent(targetNode, "mousedown");
  //triggerMouseEvent(targetNode, "mouseup");
  //triggerMouseEvent(targetNode, "click");
  // }

  // function triggerMouseEvent(node, eventType) {
  //   var clickEvent = document.createEvent('MouseEvents');
  //   clickEvent.initEvent(eventType, true, true);
  //   node.dispatchEvent(clickEvent);
  // }


})();
