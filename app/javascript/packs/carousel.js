document.addEventListener('DOMContentLoaded', (event) => {
  (function(doc) {
    const carousel = doc.getElementById('carousel-cont');
    if (carousel) {
      const images = doc.getElementsByClassName('carousel-image');
      const prevBttn = doc.getElementById('prev-bttn');
      const nextBttn = doc.getElementById('next-bttn');
      let totalImgs = images.length;
      let slide = 0;
      let moving = false;

      prevBttn.addEventListener('click', moveToNext);
      nextBttn.addEventListener('click', moveToPrev);

      function moveToNext() {
        if(!moving) {
          slide === (totalImgs - 1) ? slide = 0 : slide++;
        }
        moveCarouselTo(slide);
      }

      function moveToPrev() {
        if(!moving) {
          slide === 0 ? slide = totalImgs - 1 : slide--;
        }
        moveCarouselTo(slide);
      }

      function disableInteraction() {
        moving = true;
        setTimeout(function(){
          moving = false
        }, 500);
      }

      function moveCarouselTo(slide) {
        if(!moving) {
          disableInteraction();
          images[0].classList.remove('initial');
          for(let i = 0; i < totalImgs; i++) {
            images[i].classList.remove('prev');
            images[i].classList.remove('next');
            images[i].classList.remove('active');
          }
          let nextSlide, prevSlide;
          slide === totalImgs - 1 ? nextSlide = 0 : nextSlide = slide + 1;
          slide === 0 ? prevSlide = totalImgs - 1 : prevSlide = slide - 1;
          images[slide].classList.add('active');
          images[nextSlide].classList.add('next');
          images[prevSlide].classList.add('prev');
        }
      }
    }
  }(event.target));
});
