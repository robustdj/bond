// Make an element clickable by finding the first link it contains
$.fn.clickable = function() {
  $(this).hover(function(){ $(this).css({'cursor': 'pointer'}); }).click(function(){
    window.location = $(this).find('a:first').attr('href');
  });
}
