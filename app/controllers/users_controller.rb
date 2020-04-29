# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def index
    @users = User.where.not(id: current_user.id).page(params[:page])
  end
end
