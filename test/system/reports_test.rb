# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "show listing reports" do
    visit "/reports"
    assert_text "日報一覧"
  end

  test "show report" do
    report_1 = reports(:report_1)
    visit "/reports/#{report_1.id}"
    assert_text report_1.title
    assert_text report_1.learning_date.strftime("%Y年%m月%d日")
    assert_text report_1.description
  end

  test "new report" do
    visit "/reports/new"
    assert_text "日報新規登録"
    assert_selector "input[name='report[title]']"
    assert_selector "textarea[name='report[description]']"
    assert_button "登録"
  end

  test "create report" do
    visit "/reports/new"
    within "form" do
      fill_in "report[title]", with: "Rubyテストに入門しました"
      fill_in "report[description]", with: "テストを書きました。"
      click_button "登録"
    end

    assert_text "正常に作成されました"
  end

  test "edit report" do
    report_1 = reports(:report_1)
    visit "/reports/#{report_1.id}/edit"
    assert_text "日報編集"

    assert_equal report_1.title, find("input[name='report[title]']").value
    assert_equal report_1.learning_date.strftime("%Y-%m-%d"), find("input[name='report[learning_date]']").value, report_1.learning_date.strftime("%y-%m-%d")
    assert_equal report_1.description, find("textarea[name='report[description]']").value
    assert_button "登録"
  end

  test "update report" do
    report_1 = reports(:report_1)
    visit "/reports/#{report_1.id}/edit"
    within "form" do
      fill_in "report[title]", with: "Rubyテスト[更新]"
      click_button "登録"
    end
    assert_text "正常に更新されました"
  end

  test "delete report" do
    visit "/reports"
    accept_confirm "削除してもよろしいですか？" do
      first("a[data-method='delete']").click
    end
    assert_text "正常に削除されました"
  end
end
