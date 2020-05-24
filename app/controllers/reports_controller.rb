class ReportsController < ApplicationController
  def index
    @total = VisitorStat.count
    @last_stat = VisitorStat.last
  end

  def generate
    VisitorsReportJob.perform_later(report_params[:email])
  
    flash[:notice] = "You will get the report in a couple of minutes" # TODO: use 18n.t(..)
    redirect_to reports_path
  end

  def report_params
    params.permit(:email)
  end
end
