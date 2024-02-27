document.addEventListener("DOMContentLoaded", function () {
  const toggleButtons = document.querySelectorAll("#navbar-toggle");
  const navbarMenus = document.querySelectorAll("#navbar-menu");
  const closeButtons = document.querySelectorAll("#navbar-close, .navbar-backdrop");

  toggleButtons.forEach(function (toggleButton) {
    toggleButton.addEventListener("click", function () {
      navbarMenus.forEach(function (navbarMenu) {
        navbarMenu.classList.toggle("hidden");
      });
    });
  });

  closeButtons.forEach(function (closeButton) {
    closeButton.addEventListener("click", function () {
      navbarMenus.forEach(function (navbarMenu) {
        navbarMenu.classList.add("hidden");
      });
    });
  });
});
