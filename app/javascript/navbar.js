window.toggleNavBar = () => {
  const $navbarBurger = document.querySelector(".navbar-burger")

  if ($navbarBurger) {
    const targetId = $navbarBurger.dataset.target
    const $navMenu = document.getElementById(targetId)

    $navMenu.classList.toggle('is-active')
  }
}
