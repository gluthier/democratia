class CantonsController < ApplicationController

  def list
    render json: Canton.all
  end

  def users_in_canton
    @canton = Canton.find_by_name(params[:name])
    if !@canton.nil?
      @canton_council = User.where(canton: @canton).includes(:political_party)
      @municipalities = User.includes(:political_party).joins(:municipality).where(municipalities: { canton_id: @canton.id})
      @all_canton = @canton_council + @municipalities
    else
      render json: { status: 422 }
      return
    end
    render layout: false
  end

end
