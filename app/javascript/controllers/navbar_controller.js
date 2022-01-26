import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar"
export default class extends Controller {
  toggle() {
    const $navbarBurger = document.querySelector(".navbar-burger");

    if ($navbarBurger) {
      const targetId = $navbarBurger.dataset.target;
      const $navMenu = document.getElementById(targetId);

      $navbarBurger.classList.toggle("is-active");
      $navMenu.classList.toggle("is-active");
    }
  }
}
