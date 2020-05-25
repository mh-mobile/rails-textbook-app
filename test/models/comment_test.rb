# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "should belongs_to corrent user" do
    hiro = users(:hiro)
    comment_1 = comments(:comment_1)

    assert_equal hiro, comment_1.user
  end

  test "should belongs_to corrent commentable" do
    book_1 = books(:book_1)
    comment_1 = comments(:comment_1)
    commentable = comment_1.commentable

    assert_equal book_1, commentable
  end

  test "commented users" do
    report_1 = reports(:report_1)
    hiro = users(:hiro)
    hanako = users(:hanako)
    mh_mobile = users(:mh_mobile)
    commented_users = report_1.comments.map(&:user).uniq
    assert_equal [hiro, hanako, mh_mobile], commented_users
  end
end
