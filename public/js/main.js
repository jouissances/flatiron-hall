var http = require("http");
setInterval(function() {
    http.get("http://flatiron-hall.herokuapp.com");
}, 300000);

$('.menu-toggle').on('click', function() {
    $('.menu').toggleClass('open');
    $('.main').toggleClass('translucent');
    $('header #title').toggleClass('translucent');
    $('header .nano-content').toggleClass('translucent');
  return false;
})

$('.close').on('click', function() {
  $('.alert-box').toggleClass('hide');
})

$('.sub-menu > a').on('click', function() {
  let isVisible = $('ul ul').is(':visible');
  if (isVisible === true) {
    $('ul ul').slideUp();
  } else {
    $('ul ul').slideDown();
  }
  return false;
})

$('ul ul a').on('click', function() {
  let filterValue = $(this).attr('data-filter');
	$('.project').hide();
  $(filterValue).show();
  return false;
})
