# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentale, only: [:create]

  def update
  end

  def destroy
  end

  def create

  end

  private 

    def set_commentable
      @commentable = params[:commentable_type].constantize.find(param[:commentable_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :commentable_type, :commentable_id, :comment_id)
    end

end
