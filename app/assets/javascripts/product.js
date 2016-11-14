$(function() {
  $("#btn-switch-before").click(function() {
    $(".img-after").hide();
    $(".img-before").show(500);
  });
  $('#btn-switch-after').click(function() {
    $(".img-before").hide();
    $(".img-after").show(500);
  });
  $('#btn-switch-none').click(function() {
    $(".img-before").hide();
    $(".img-after").hide();
  });
});
