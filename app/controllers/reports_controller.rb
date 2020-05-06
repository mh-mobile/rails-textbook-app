class ReportsController < ApplicationController
    def index
      @reports = Report.all.page(params[:page])
    end
  
    def create
    end
  
    def update
    end
  
    def destroy
    end
  
    def show 
    end
end
