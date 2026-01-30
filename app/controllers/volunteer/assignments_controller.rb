class Volunteer::AssignmentsController < ApplicationController
  before_action :require_authentication

  def index
    @assignments = Current.user.assignments
      .includes(event: :team, position: {})
      .joins(:event)
      .order("events.starts_at DESC")
  end

  def update
    @assignment = Current.user.assignments.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to volunteer_assignments_path, notice: "Response saved."
    else
      redirect_to volunteer_assignments_path, alert: "Could not update assignment."
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:status)
  end
end