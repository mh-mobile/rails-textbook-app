# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all.page(params[:page])
  end

  def new
    @report = Report.new(learning_date: Date.current)
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    if @report.save
      redirect_to @report, notice: t("flash.actions.create.notice")
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("flash.actions.update.notice")
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: t("flash.actions.destroy.notice")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :description, :learning_date)
    end
end
