# frozen_string_literal: true

module LoginHelper
  def login_user(name, password)
    visit "/login"
    within("#new_user") do
      fill_in "user[login]", with: name
      fill_in "user[password]", with: password
    end
    click_button "ログイン"
  end
end
