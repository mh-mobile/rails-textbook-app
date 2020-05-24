# frozen_string_literal: true

require "application_system_test_case"

class FollowingTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "show listing following" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    visit "/users/#{mh_mobile.username}/following"
    assert_text "Following"
    assert_text hiro.username
  end

  test "create following" do
    taro = users(:taro)
    visit "/users"
    find("#user-#{taro.id} > a").click
    mh_mobile = users(:mh_mobile)
    visit "/users/#{mh_mobile.username}/following"
    assert_text taro.username
  end

  test "destroy following" do
    hiro = users(:hiro)
    visit "/users"
    find("#user-#{hiro.id} > a").click
    mh_mobile = users(:mh_mobile)
    visit "/users/#{mh_mobile.username}/following"
    assert_no_text hiro.username
  end
end
