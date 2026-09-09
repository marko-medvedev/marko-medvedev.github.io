/* Minimal progressive enhancement.
   1. Footer year.
   2. Light/dark toggle. Light is the default; the choice is remembered.
   3. Turn the obfuscated email into a real mailto link at runtime, so the
      address never appears in the served HTML for scrapers to harvest. */

(function () {
  "use strict";

  var year = document.getElementById("year");
  if (year) year.textContent = new Date().getFullYear();


  /* --- theme toggle ---------------------------------------------------- */

  var root = document.documentElement;
  var toggle = document.getElementById("theme-toggle");

  if (toggle) {
    var meta = document.querySelector('meta[name="theme-color"]');

    var paint = function (theme) {
      var dark = theme === "dark";
      toggle.setAttribute("aria-pressed", dark ? "true" : "false");
      toggle.setAttribute("aria-label",
        dark ? "Switch to light theme" : "Switch to dark theme");
      var text = toggle.querySelector(".theme-toggle-text");
      if (text) text.textContent = dark ? "Light" : "Dark";
      if (meta) meta.setAttribute("content", dark ? "#10141a" : "#ffffff");
    };

    /* No JS means no toggle, so it ships hidden and is revealed here. */
    toggle.hidden = false;
    paint(root.getAttribute("data-theme") === "dark" ? "dark" : "light");

    toggle.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      paint(next);
      try { localStorage.setItem("theme", next); } catch (e) {}
    });
  }

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
