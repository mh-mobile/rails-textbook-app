# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create]

  def update
  end

  def destroy
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable
    if @comment.save
      @comments = @commentable.comments
    else
      redirect_to "/#{@commentable.class.to_s.downcase.pluralize}/#{@commentable.id}", alert: "作成できませんでした"
    end
  end

  private 

    def set_commentable
      @commentable = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :commentable_type, :commentable_id, :comment_id)
    end

end
