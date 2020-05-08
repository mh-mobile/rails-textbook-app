// jqueryでコメントの編集ボタンのclickイベントを設定
$("body").on("click", ".comment .edit_button", function () {
  changeCommentView(true, this);
});

// jqueryでコメントのキャンセルボタンのclickイベントを設定
$("body").on("click", ".comment .cancel_button", function () {
  changeCommentView(false, this);
});

// 編集状態に応じて、コメントビューを変更する。
// 編集中の場合は、編集モードのコメントビューを表示する。
// 編集中ではない場合は、通常モードのコメントビューを表示する。
function changeCommentView(editing, targetElm) {
  // commentクラスの親ビューを検索
  var parentComment = $(targetElm).closest(".comment")[0];

  // 親ビューから編集モードと通常モードのコメントビューを検索
  var editComment = parentComment.querySelector(".edit-comment");
  var normalComment = parentComment.querySelector(".normal-comment");

  // 各コメントビューの表示状態を変更する。
  if (editing) {
    $(normalComment).css("display", "none");
    $(editComment).css("display", "flex");
  } else {
    $(normalComment).css("display", "flex");
    $(editComment).css("display", "none");
  }
}
