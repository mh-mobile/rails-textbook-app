# frozen_string_literal: true

require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should belongs_to corrent user" do
    mh_mobile = users(:mh_mobile)
    book_1 = books(:book_1)

    assert_equal mh_mobile, book_1.user
  end

  test "#save" do
    mh_mobile = users(:mh_mobile)
    book = Book.new(
      title: "タイトル",
      author: "著者",
      memo: "メモ",
      user: mh_mobile,
      created_at: "2020-01-06 00:00:0"
      )
    book.save
    assert book["id"].present?
  end

  test ".following_feeds" do
    mh_mobile = users(:mh_mobile)
    hanako = users(:hanako)
    taro = users(:taro)

    mh_mobile.follow!(hanako)
    mh_mobile.follow!(taro)
    following_feeds = Book.following_feeds(mh_mobile)
    expected_feeds = [
      books(:book_6),
      books(:book_5),
      books(:book_4),
      books(:book_3),
      books(:book_2),
      books(:book_1),
    ]

    assert_equal expected_feeds, following_feeds
  end
end
