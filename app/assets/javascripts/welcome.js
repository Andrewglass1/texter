$(function() {
  $('#submit-form').bind('click',function(event) {
    $('form#instruction-form').submit(function( event ) {
      $('form#instruction-form').hide()
      $('#thanks').show()
    })
  });

  $('#contact-text').bigtext();
  $('#mobile-credit-text').bigtext();

});
