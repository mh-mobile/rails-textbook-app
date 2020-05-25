# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "create comment" do
    report_1 = reports(:report_1)
    visit "/reports/#{report_1.id}"

    within ".columns form" do
      fill_in "comment[content]", with: "テスト投稿です"
      click_button "コメントする"
    end
    sleep 10

    assert has_text?(:visible, "テスト投稿です")
  end

  test "update comment" do
    report_1 = reports(:report_1)
    comment_9 = comments(:comment_9)
    visit "/reports/#{report_1.id}"
    within "#comment-#{comment_9.id} .normal-comment" do
      click_link "編集"
    end

    within "#comment-#{comment_9.id} .edit-comment" do
      fill_in "comment[content]", with: "コメント更新"
      click_button "保存"
    end

    sleep 10

    assert has_text?(:visible, "コメント更新")
  end

  test "delete comment" do
    report_1 = reports(:report_1)
    comment_9 = comments(:comment_9)
    visit "/reports/#{report_1.id}"
    within "#comment-#{comment_9.id} .normal-comment" do
      accept_confirm "削除してもよろしいですか？" do
        click_link "削除"
      end
    end

    sleep 10

    assert_no_text comment_9.content
  end
end
