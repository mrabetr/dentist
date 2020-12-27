const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-home');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 0.1 * window.innerHeight) {
        navbar.classList.add('navbar-home-white');
      } else {
        navbar.classList.remove('navbar-home-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
