class Admin::AssignmentsController < ApplicationController
  before_action :set_event

  def new
    @assignment = @event.assignments.new
    @positions = @event.team.positions
    @users = User.all
  end

  def create
    @assignment = @event.assignments.new(assignment_params)
    
    if check_conflicts && @assignment.save
      redirect_to admin_event_path(@event), notice: "Assignment created."
    else
      @positions = @event.team.positions
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @assignment = @event.assignments.find(params[:id])
    @assignment.destroy
    redirect_to admin_event_path(@event), notice: "Assignment removed."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def assignment_params
    params.require(:assignment).permit(:user_id, :position_id)
  end

  def check_conflicts
    user = User.find(assignment_params[:user_id])
    
    event_day = @event.starts_at.wday
    availability = user.availabilities.find_by(day_of_week: event_day)
    
    unless availability
      @assignment.errors.add(:base, "#{user.email_address} has no availability set for #{Date::DAYNAMES[event_day]}")
      return false
    end

    event_start = @event.starts_at.strftime("%H:%M")
    event_end = @event.ends_at.strftime("%H:%M")
    avail_start = availability.start_time.strftime("%H:%M")
    avail_end = availability.end_time.strftime("%H:%M")

    unless event_start >= avail_start && event_end <= avail_end
      @assignment.errors.add(:base, "#{user.email_address} is not available during this time slot")
      return false
    end

    true
  end
end