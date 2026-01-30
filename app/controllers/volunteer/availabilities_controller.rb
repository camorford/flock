class Volunteer::AvailabilitiesController < ApplicationController
  before_action :require_authentication

  def index
    @availabilities = Current.user.availabilities.order(:day_of_week)
  end

  def new
    @availability = Current.user.availabilities.new
  end

  def create
    @availability = Current.user.availabilities.new(availability_params)
    if @availability.save
      redirect_to volunteer_availabilities_path, notice: "Availability added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @availability = Current.user.availabilities.find(params[:id])
    @availability.destroy
    redirect_to volunteer_availabilities_path, notice: "Availability removed."
  end

  private

  def availability_params
    params.require(:availability).permit(:day_of_week, :start_time, :end_time)
  end
end