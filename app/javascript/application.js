// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.toggleNavBar = () => {
  const $navbarBurger = document.querySelector(".navbar-burger")

  if ($navbarBurger) {
    const targetId = $navbarBurger.dataset.target
    const $navMenu = document.getElementById(targetId)

    $navbarBurger.classList.toggle('is-active')
    $navMenu.classList.toggle('is-active')
  }
}
