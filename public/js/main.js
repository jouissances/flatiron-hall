$('.menu-toggle').on('click', function() {
    $('.menu').toggleClass('open');
    $('.main').toggleClass('translucent');
  return false;
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