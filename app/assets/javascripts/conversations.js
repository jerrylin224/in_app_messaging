$(document).on('turbolinks:load',function() {
  var pinned;
  $(".conversation .pin_item").click(function (e){
    e.preventDefault();
    if ($(this).hasClass("pinned")) {
      $(this).removeClass("pinned");
      pinned = false;
    } else {
      $(this).addClass("pinned");
      pinned = true;
    }
  });
});
