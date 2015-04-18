class DistrictsController < ApplicationController

  def users_in_district
    @district = District.find_by_name(params[:name])
    if !@district.nil?
      @users = User.find_by_district(@district.id)
      render json: @users
    else
      render json: { status: 422 }
    end
  end

end