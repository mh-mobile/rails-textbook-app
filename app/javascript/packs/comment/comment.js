var commentTimeline = document.querySelector("#comment-timeline");

// コメントの編集・キャンセルボタンのclickイベントを設定
commentTimeline.addEventListener(
  "click",
  function (event) {
    var target = event.target;
    if (isTargetElm(target, "edit_button")) {
      changeCommentView(true, target);
    } else if (isTargetElm(target, "cancel_button")) {
      changeCommentView(false, target);
    }
  },
  false
);

function isTargetElm(target, className) {
  return target.classList.contains(className) && target.closest(".comment");
}

// 編集状態に応じて、コメントビューを変更する。
// 編集中の場合は、編集モードのコメントビューを表示する。
// 編集中ではない場合は、通常モードのコメントビューを表示する。
function changeCommentView(editing, targetElm) {
  // commentクラスの親ビューを検索
  var parentComment = targetElm.closest(".comment");

  // 親ビューから編集モードと通常モードのコメントビューを検索
  var editComment = parentComment.querySelector(".edit-comment");
  var normalComment = parentComment.querySelector(".normal-comment");

  // 各コメントビューの表示状態を変更する。
  normalComment.style.display = editing ? "none" : "flex";
  editComment.style.display = editing ? "flex" : "none";
}
