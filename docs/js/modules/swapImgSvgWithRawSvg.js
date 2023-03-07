import './external/svg-inject.min.js';

/* To change any <img> loading a .svg to be that .svg inline */
SVGInject( document.querySelectorAll('img[src$=".svg"]'), {
  onAllFinish: function() {
      console.info('Image SVGs replaced with inline SVGs.');
  }
});
