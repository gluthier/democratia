class MunicipalitiesController < ApplicationController

  def list
    render json: Municipality.all
  end

  def users_in_municipality
    @municipality = Municipality.find_by_name(params[:name])
    if !@municipality.nil?
      @users = User.find_by_district(@municipality.id)
      render json: @users
    else
      render json: { status: 422 }
    end
  end

end