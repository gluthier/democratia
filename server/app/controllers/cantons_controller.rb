class CantonsController < ApplicationController

  def list
    render json: Canton.all
  end

  def users_in_canton
    @canton = Canton.find_by_name(params[:name])
    if !@canton.nil?
      @users = User.find_by_canton_id(@canton.id)
      render json: @users
    else
      render json: { status: 422 }
    end
  end

end