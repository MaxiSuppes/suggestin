class EnableReportsController < ApplicationController

  protect_from_forgery with: :null_session

  # GET /print
  def updateReports
    user = User.find(params[:id])
    user.has_reports = true
    user.save
  end

  def updateBenchmark
    user = User.find(params[:id])
    user.has_benchmark = true
    user.save
  end

end