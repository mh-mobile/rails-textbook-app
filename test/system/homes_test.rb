# frozen_string_literal: true

require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "show top page" do
    visit "/"
    assert_text "BookAppへようこそ"
    assert_link "ログイン"
    assert_link "サインアップ"
  end
end
