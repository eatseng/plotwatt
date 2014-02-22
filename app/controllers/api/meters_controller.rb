class Api::MetersController < ApplicationController
  def data
    monthly_data = Meter.monthly(params[:year])
    render :json => monthly_data
  end
end
