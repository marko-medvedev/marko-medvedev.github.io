/* Minimal progressive enhancement.
   1. Footer year.
   2. Turn the obfuscated email into a real mailto link at runtime, so the
      address never appears in the served HTML for scrapers to harvest. */

(function () {
  "use strict";

  var year = document.getElementById("year");
  if (year) year.textContent = new Date().getFullYear();

  var slot = document.querySelector(".email");
  if (!slot) return;

  var user = slot.getAttribute("data-user");
  var domain = slot.getAttribute("data-domain");
  if (!user || !domain) return;

  var address = user + String.fromCharCode(64) + domain;
  var link = document.createElement("a");
  link.href = "mailto:" + address;
  link.textContent = address;
  slot.replaceChildren(link);
})();
