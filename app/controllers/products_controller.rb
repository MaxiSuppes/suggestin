class ProductsController < ApplicationController

  protect_from_forgery with: :null_session

  # PUT /enable_reports
  def updateReports
    user = User.find(params[:id])
    user.has_reports = true
    user.save
  end

  # PUT /enable_benchmark
  def updateBenchmark
    user = User.find(params[:id])
    user.has_benchmark = true
    user.save
  end

  #DELETE /delete_reports
  def deleteReports
    user = User.find(params[:id])
    user.has_reports = false
    user.save
  end

  #DELETE /delete_benchmark
  def deleteBenchmark
    user = User.find(params[:id])
    user.has_benchmark = false
    user.save
  end

end