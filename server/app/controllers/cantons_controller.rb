class CantonsController < ApplicationController

  def list
    render json: Canton.all
  end

  def users_in_canton
    @canton = Canton.find_by_name(params[:name])
    if !@canton.nil?
      @users = User.where(canton: @canton).includes(:political_party)
    else
      render json: { status: 422 }
      return
    end
    render layout: false
  end

end
