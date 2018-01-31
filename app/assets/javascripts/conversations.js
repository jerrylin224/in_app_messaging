$(document).on('turbolinks:load',function() {

  function togglePin(e) {
    let pinned;

    e.preventDefault();
    if ($(this).hasClass("pinned")) {
      $(this).removeClass("pinned");
      pinned = false;
    } else {
      $(this).addClass("pinned");
      pinned = true;
    }
  }

  function toggleSelectAll(e) {
    e.preventDefault()
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  }

  $(".conversation .pin_item").click(togglePin);

  $('#select_all').click(toggleSelectAll);
});
