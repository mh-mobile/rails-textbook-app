# frozen_string_literal: true

require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "show signup" do
    visit "users/new"
    assert_text "会員登録"
    assert_selector "input[name='user[username]']"
    assert_selector "input[name='user[email]']"
    assert_selector "input[name='user[password]']"
    assert_selector "input[name='user[password_confirmation]']"
    assert_button "サインアップ"
  end

  test "signup with correct info" do
    visit "users/new"
    within("#new_user") do
      fill_in "user[username]", with: "kobayashi"
      fill_in "user[email]", with: "kobayashi@example.com"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
      fill_in "user[password_confirmation]", with: "QjT7QeyjUDUYz2Fy"
    end
    click_button "サインアップ"

    assert_equal "/", current_path
    assert_text "アカウント登録が完了しました。"
  end

  test "signup with wrong username" do
    visit "users/new"
    within("#new_user") do
      fill_in "user[username]", with: "mh"
      fill_in "user[email]", with: "mh@example.com"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
      fill_in "user[password_confirmation]", with: "QjT7QeyjUDUYz2Fy"
    end
    click_button "サインアップ"

    assert_text <<-EOF
登録に失敗しました。
ユーザー名 は3文字以上を入力してください。
    EOF
  end

  test "signup with wrong password" do
    visit "users/new"
    within("#new_user") do
      fill_in "user[username]", with: "kobayashi"
      fill_in "user[email]", with: "kobayashi@example.com"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
      fill_in "user[password_confirmation]", with: "[wrong_password]"
    end
    click_button "サインアップ"

    assert_text <<-EOF
登録に失敗しました。
パスワード確認 はパスワードと一致しません。
    EOF
  end
end
