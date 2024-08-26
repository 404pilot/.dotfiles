// ==UserScript==
// @name         Quick Searcher
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Do a web search on selected text
// @author       404pilot
// @match        https://onedrive.visualstudio.com/*
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  function getAdoSearchUrl(selectedText) {
    const currentUrl = window.location.href;
    const urlObj = new URL(currentUrl);
    const pathSegments = urlObj.pathname.split("/").filter(Boolean);
    const query = encodeURIComponent(selectedText);
    return `${urlObj.origin}/${pathSegments[0]}/_search?type=code&text="${query}"`;
  }

  let icon = document.createElement("img");
  icon.src = "https://www.bing.com/sa/simg/favicon-2x.ico";
  icon.style.position = "absolute";
  icon.style.zIndex = 1000;
  icon.style.cursor = "pointer";
  icon.style.display = "none"; // Initially hidden
  icon.width = 30;
  icon.height = 30;

  document.body.appendChild(icon);

  document.addEventListener("mouseup", function (event) {
    let selectedText = window.getSelection().toString().trim();
    if (selectedText.length > 0) {
      let x = event.pageX;
      let y = event.pageY;

      // Show the icon near the selection
      icon.style.left = x + "px";
      icon.style.top = y + 30 + "px"; // Slightly below the selection
      icon.style.display = "block";

      // Add click event to open Google search
      icon.onclick = function () {
        window.open(getAdoSearchUrl(selectedText), "_blank");
      };
    } else {
      icon.style.display = "none";
    }
  });

  // Hide the icon when clicking elsewhere
  document.addEventListener("mousedown", function (event) {
    if (!icon.contains(event.target)) {
      icon.style.display = "none";
    }
  });
})();
