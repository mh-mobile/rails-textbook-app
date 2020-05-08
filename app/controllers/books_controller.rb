# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action -> {
    check_permission(@book.user)
  }, only: [:edit, :update, :destroy]

  # GET /books
  def index
    feeds = Book.following_feeds(current_user)
    @books = feeds.page(params[:page])
  end

  # GET /books/1
  def show
    @comments = @book.comments
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to @book, notice: t("flash.actions.create.notice")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("flash.actions.update.notice")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t("flash.actions.destroy.notice")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
