# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "commented users" do
    report_1 = reports(:report_1)
    hiro = users(:hiro)
    hanako = users(:hanako)
    mh_mobile = users(:mh_mobile)
    commented_users = report_1.comments.map(&:user).uniq
    assert_equal [hiro, hanako, mh_mobile], commented_users
  end
end
