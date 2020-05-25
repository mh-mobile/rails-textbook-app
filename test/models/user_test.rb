# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
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
    hanako = users(:hanako)

    assert_difference -> { mh_mobile.following.count } => 1, -> { hanako.followers.count } => 1 do
      mh_mobile.follow!(hanako)
    end
  end

  test "#unfollow!" do
    mh_mobile = users(:mh_mobile)
    taro = users(:taro)
    hanako = users(:hanako)

    assert_difference "mh_mobile.following.count", 2 do
      mh_mobile.follow!(taro)
      mh_mobile.follow!(hanako)
    end

    assert_difference "mh_mobile.following.count", -1 do
      mh_mobile.unfollow!(taro)
    end

    assert_equal 0, taro.followers.count
    assert_equal 1, hanako.followers.count
  end

  test "#following" do
    mh_mobile = users(:mh_mobile)
    hanako = users(:hanako)
    taro = users(:taro)

    assert_difference "mh_mobile.following.count", 2 do
      mh_mobile.following << [hanako, taro]
    end
  end

  test "#followers" do
    mh_mobile = users(:mh_mobile)
    hanako = users(:hanako)
    hiro = users(:hiro)
    taro = users(:taro)

    assert_difference "mh_mobile.followers.count", 3 do
      mh_mobile.followers << [hanako, hiro, taro]
    end
  end
end
