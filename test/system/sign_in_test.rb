# frozen_string_literal: true

require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  test "sign in with login name" do
    visit "/login"
    within("#new_user") do
      fill_in "user[login]", with: "mh-mobile"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
    end
    click_button "ログイン"

    assert_equal "/", current_path
    assert_text "ログインしました。"
  end

  test "sign in with login email" do
    visit "/login"
    within("#new_user") do
      fill_in "user[login]", with: "mh-mobile@example.com"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
    end
    click_button "ログイン"

    assert_equal "/", current_path
    assert_text "ログインしました。"
  end

  test "sign in with invalid password" do
    visit "/login"
    within("#new_user") do
      fill_in "user[login]", with: "mh-mobile@example.com"
      fill_in "user[password]", with: "invalid"
    end
    click_button "ログイン"

    assert_equal "/login", current_path
    assert_text "ユーザー名 or メールアドレスまたはパスワードが違います。"
  end

  test "logout after sign in" do
    visit "/login"
    within("#new_user") do
      fill_in "user[login]", with: "mh-mobile"
      fill_in "user[password]", with: "QjT7QeyjUDUYz2Fy"
    end
    click_button "ログイン"

    visit "/logout"
    using_wait_time 3 do
      assert_text "ログアウトしました。"
      assert_text "BookAppへようこそ"
    end
  end
end
