$(function(){
    $('ol.faq a').click(function() {
      $(this).next().slideToggle("fast");
      return false;
    });
});
