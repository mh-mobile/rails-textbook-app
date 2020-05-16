# frozen_string_literal: true

require "test_helper"

class ReportTest < ActiveSupport::TestCase
  test "should belongs_to corrent user" do
    mh_mobile = users(:mh_mobile)
    report_1 = reports(:report_1)

    assert_equal mh_mobile, report_1.user
  end

  test "#save" do
    mh_mobile = users(:mh_mobile)
    report = Report.new(
      title: "日報を提出",
      description: "日報の内容",
      learning_date: Date.current,
      user: mh_mobile
      )
    report.save
    assert report["id"].present?
  end
end
