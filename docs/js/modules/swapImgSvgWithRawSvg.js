import 'https://cdn.jsdelivr.net/npm/@iconfu/svg-inject@1.2.3/dist/svg-inject.min.js';

/* To change any <img> loading a .svg to be that .svg inline */
SVGInject( document.querySelectorAll('.logo'), {
  onAllFinish: () => console.info('Image SVGs replaced with inline SVGs.')
});
