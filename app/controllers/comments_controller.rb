# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :update]
  before_action :set_comment, only: [:update, :destroy]
  before_action -> {
    check_permission(@comment.user)
  }, only: [:update, :destroy]

  def update
    unless @comment.update(comment_params)
      redirect_to commentable_path, alert: t("flash.actions.update.alert")
    end
  end

  def destroy
    unless @comment.destroy
      redirect_to commentable_path, alert: t("flash.actions.destroy.alert")
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable
    if @comment.save
      @comments = @commentable.comments.order(created_at: :ASC)
    else
      redirect_to commentable_path, alert: t("flash.actions.create.alert")
    end
  end

  private
    def commentable_path
      "/#{@commentable.plural_name}/#{@commentable.id}"
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      @commentable = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :commentable_type, :commentable_id, :comment_id)
    end
end
