document.addEventListener('DOMContentLoaded', (event) => {
  const hamburger = event.target.getElementById('hamburger');
  const topBar = event.target.getElementById('top-bar');
  const midBar = event.target.getElementById('mid-bar');
  const bottomBar = event.target.getElementById('bottom-bar');
  const sideNav = event.target.querySelector('.side-nav');

  let animationCount = 0;

  hamburger.addEventListener('click', function () {
    if (animationCount % 2 === 0) {
      topBar.classList.remove('reverse-top-animation')
      topBar.classList.add('top-animation');
      midBar.classList.remove('reverse-mid-animation')
      midBar.classList.add('mid-animation');
      bottomBar.classList.remove('reverse-bottom-animation')
      bottomBar.classList.add('bottom-animation');
    } else {
      topBar.classList.remove('top-animation')
      topBar.classList.add('reverse-top-animation');
      midBar.classList.remove('mid-animation')
      midBar.classList.add('reverse-mid-animation');
      bottomBar.classList.remove('bottom-animation')
      bottomBar.classList.add('reverse-bottom-animation');
    }
    animationCount++;
    closeMenu();
  });

  function closeMenu() {
    sideNav.classList.remove('close-menu');
    sideNav.classList.add('close-menu');
  }
});
