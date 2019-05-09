// 非同期通信でコメントが保存されるようにする

$(function(){
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href = /users/${comment.user_id}> ${comment.user_name} </a>
                    :
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }

  // フォームが送信されたら、イベントが発火
  $('#new_comment').on('submit', function(e){
    // フォームを送信するための通信を止める
    e.preventDefault();
    // コメントフォームの情報を取得
    var formData = new FormData(this);
    // フォームの送信先のurlを定義
    var href = window.location.href + '/comments'

    // ajaxで非同期通信に必要なオプションの設定
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    // 非同期通信に成功したとき
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html)
      $('.textbox').val('')
    })

    // 非同期通信に失敗したとき
    .fail(function(){
      alert('error');
    })
  })
});

 
