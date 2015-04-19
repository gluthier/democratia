class MunicipalitiesController < ApplicationController

  def list
    render json: Municipality.all
  end

  def users_in_municipality
    @municipality = Municipality.find_by_name(params[:name])
    if !@municipality.nil?
      @users = User.where(municipality_id: @municipality.id)
      render layout: false
      return
    end
    render json: { status: 422 }
  end

end