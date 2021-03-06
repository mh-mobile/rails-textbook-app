# frozen_string_literal: true

require "test_helper"
require_relative "supports/login_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include LoginHelper

  driven_by :selenium, using: :headless_chrome

  setup {
    # Ajax対策のため長めに待機
    Capybara.default_max_wait_time = 30
  }
end
