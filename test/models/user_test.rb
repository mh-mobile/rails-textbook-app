# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#save" do
    user = User.new(
      username: "tanaka",
      email: "tanaka@example.com",
      password: "QjT7QeyjUDUYz2Fy",
      password_confirmation: "QjT7QeyjUDUYz2Fy",
      uid: User.create_unique_string
      )
    user.save
    assert user["id"].present?
  end

  test "#forward_postcode" do
    taro = users(:taro)
    assert_equal "100", taro.forward_postcode
  end

  test "#backward_postcode" do
    taro = users(:taro)
    assert_equal "0005", taro.backward_postcode
  end

  test "#follow!" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)

    mh_mobile.follow!(hiro)
    assert_equal 1, mh_mobile.following.count
    assert_equal 1, hiro.followers.count
  end

  test "#unfollow!" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    hanako = users(:hanako)

    mh_mobile.follow!(hiro)
    mh_mobile.follow!(hanako)
    mh_mobile.unfollow!(hiro)

    assert_equal 1, mh_mobile.following.count
    assert_equal 0, hiro.followers.count
    assert_equal 1, hanako.followers.count
  end

  test "#following" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    hanako = users(:hanako)
    taro = users(:taro)

    mh_mobile.following << [hiro, hanako, taro]
    assert_equal 3, mh_mobile.following.count
  end

  test "#followers" do
    mh_mobile = users(:mh_mobile)
    hiro = users(:hiro)
    hanako = users(:hanako)
    taro = users(:taro)
    mh_mobile.followers << [hiro, hanako, taro]

    assert_equal 3, mh_mobile.followers.count
  end
end
