class Volunteer::DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @upcoming_assignments = Current.user.assignments
      .includes(event: :team, position: {})
      .joins(:event)
      .where("events.starts_at >= ?", Time.current)
      .order("events.starts_at ASC")
  end
end