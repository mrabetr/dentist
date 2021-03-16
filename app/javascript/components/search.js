const searchInputShadowOnMouseover = () => {
  const searchInput = document.querySelector('#query');
  if (searchInput) {
    searchInput.addEventListener('mouseover', (event) => {
      searchInput.classList.add('shadow');
    });
    searchInput.addEventListener('mouseout', (event) => {
      searchInput.classList.remove('shadow');
    });
  }
}

export { searchInputShadowOnMouseover };
