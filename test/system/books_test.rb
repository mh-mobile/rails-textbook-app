# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup { login_user "mh-mobile", "QjT7QeyjUDUYz2Fy" }

  test "show listing books" do
    visit "/books"
    assert_text "書籍一覧"
  end

  test "show book" do
    book_1 = books(:book_1)
    visit "/books/#{book_1.id}"
    assert_text book_1.title
    assert_text book_1.memo
    assert_text book_1.author
  end

  test "new book" do
    visit "/books/new"
    assert_text "書籍新規登録"
    assert_selector "input[name='book[title]']"
    assert_selector "textarea[name='book[memo]']"
    assert_selector "input[name='book[author]']"
    assert_selector "input[name='book[picture]']"
    assert_button "登録"
  end

  test "create book" do
    visit "/books/new"
    within "form" do
      fill_in "book[title]", with: "Rubyテスト"
      fill_in "book[memo]", with: "テスト本"
      fill_in "book[author]", with: "テストエキスパート"
      click_button "登録"
    end

    assert_text "正常に作成されました"
  end

  test "edit book" do
    book_1 = books(:book_1)
    visit "/books/#{book_1.id}/edit"
    assert_text "書籍編集"
    assert_equal book_1.title, find("input[name='book[title]']").value
    assert_equal book_1.memo, find("textarea[name='book[memo]']").value
    assert_equal book_1.author, find("input[name='book[author]']").value
    assert_button "登録"
  end

  test "update book" do
    book_1 = books(:book_1)
    visit "/books/#{book_1.id}/edit"
    within "form" do
      fill_in "book[title]", with: "Rubyテスト[更新]"
      click_button "登録"
    end
    assert_text "正常に更新されました"
  end

  test "delete book" do
    visit "/books"
    accept_confirm "削除してもよろしいですか？" do
      first("a[data-method='delete']").click
    end
    assert_text "正常に削除されました"
  end
end
