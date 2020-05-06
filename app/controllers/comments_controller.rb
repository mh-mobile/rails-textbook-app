# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentale

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

end
