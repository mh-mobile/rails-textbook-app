# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "show listing users" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    hanako = users(:hanako)
    taro = users(:taro)

    visit "/users"
    assert_text "ユーザーリスト"
    assert_text hiro.username
    assert_text hanako.username
    assert_text taro.username
    assert_no_text mh_mobile.username
  end

  test "show user" do
    hiro = users(:hiro)
    visit "/users/#{hiro.username}"
    assert_text "プロフィール"
    assert_text hiro.username
  end
end
