class CommunesController < ApplicationController

  def users_in_commune
    @commune = Commune.find_by_name(params[:name])
    if !@commune.nil?
      @users = User.find_by_district(@commune.id)
      render json: @users
    else
      render json: { status: 422 }
    end
  end

end