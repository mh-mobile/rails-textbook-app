# frozen_string_literal: true

require "application_system_test_case"

class FollowersTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "show listing followers" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    visit "/users/#{hiro.username}/followers"
    assert_text "Followers"
    assert_text mh_mobile.username
  end
end
