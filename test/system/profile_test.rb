# frozen_string_literal: true

require "application_system_test_case"

class ProfileTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "edit current user's profile" do
    mh_mobile = users(:mh_mobile)
    visit "/me/edit"
    assert_text "プロフィール編集"
    assert_equal find("input[name='user[username]']").value, mh_mobile.username
  end

  test "update current user's profile" do
    visit "/me/edit"
    within "form" do
      fill_in "user[forward_postcode]", with: "100"
      fill_in "user[backward_postcode]", with: "0005"
      fill_in "user[address]", with: "東京都港区"
      fill_in "user[self_introduction]", with: "東京出身です"
      click_button "更新"
    end

    sleep 3
    assert_text "アカウント情報を変更しました。"
  end
end
