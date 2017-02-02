// ボタンをクリックしたら画像の表示が切り替わる
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


// クリックされた順番で順位をつける
$(function() {
  var first_text = $('#first').text();
  var second_text = $('#second').text();
  var third_text = $('#third').text();
  $('.click-order.first.second.third').on('click', function(){
    if ($(this).hasClass('first') && $(this).hasClass('second') && $(this).hasClass('third')) {
      $(this).addClass('clicked');
      $(this).removeClass('second third unclicked');
      var content = $(this).text();
      $(this).text('1位' + '.' + content);
      $('.click-order' + '.first' + '.second' + '.third').each(function(){
        $(this).removeClass('first');
      });
    } else if ($(this).hasClass('second') && $(this).hasClass('third')) {
      $(this).addClass('clicked');
      $(this).removeClass('third unclicked');
      var content = $(this).text();
      $(this).text('2位' + '.' + content);
      $('.click-order' + '.second' + '.third').each(function(){
        $(this).addClass('clicked');
        $(this).removeClass('second unclicked');
        var content = $(this).text();
        $(this).text('3位' + '.' + content);
        console.log(first_text);
        console.log(second_text);
        console.log(third_text);
        $('.redo').show();
        if ($('.redo').show()) {
          $('.redo').on('click', function(){
            $('.click-order').addClass('first second third');
            $('.click-order').removeClass('clicked');
            $('#first').text(first_text);
            $('#second').text(second_text);
            $('#third').text(third_text);
            $(this).hide();
          });
        }
      });
    }
  });
});


// removeClassを実行後のclickイベントの挙動について確認
$(function() {

  $('#block-1 .one.two.three').on('click', clickOrder);

  function clickOrder(){
    if ($(this).hasClass('one') && $(this).hasClass('two') && $(this).hasClass('three')) {
      $(this).removeClass('two three');
        var sentence = $(this).text();
        $(this).text('1番目.' + sentence);
      $('.two.three').each(function(i){
        if(i === 2) {
          return false;
        }
        $(this).removeClass('one');
      });
    } else if ($(this).hasClass('two') && $(this).hasClass('three')) {
      $(this).removeClass('three');
      var sentence = $(this).text();
      $(this).text('2番目.' + sentence);
      $('.two.three').each(function(i){
        if(i === 1) {
          return false;
        }
        $(this).removeClass('two');
        var sentence = $(this).text();
        $(this).text('3番目.' + sentence);
      });
    }
  }

});
