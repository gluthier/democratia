class PoliticalPartiesController < ApplicationController

  def political_party_users
    @party = PoliticalParty.find_by_name(params[:name])
    if !@party.nil?
      render json: @party.users
    else
      render json: {status: 422}
    end
  end

end
