# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all.page(params[:page])
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: t("flash.actions.destroy.notice")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end
end
