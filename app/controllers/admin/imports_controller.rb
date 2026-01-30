class Admin::ImportsController < ApplicationController
  before_action :require_pco_connection

  def show
    service = PlanningCenterService.new(session[:pco_access_token])
    @pco_teams = service.fetch_teams
    @pco_people = service.fetch_people
    @pco_plans = service.fetch_plans
  end

  def create_teams
    service = PlanningCenterService.new(session[:pco_access_token])
    teams = service.fetch_teams
    
    imported = 0
    teams.each do |team_data|
      team = Team.find_or_initialize_by(name: team_data[:name])
      if team.new_record? && team.save
        imported += 1
      end
    end
    
    redirect_to admin_import_path, notice: "Imported #{imported} new teams from Planning Center."
  end

  def create_people
    service = PlanningCenterService.new(session[:pco_access_token])
    people = service.fetch_people
    
    imported = 0
    people.each do |person_data|
      next if person_data[:email].blank?
      
      user = User.find_or_initialize_by(email_address: person_data[:email])
      if user.new_record?
        user.name = person_data[:name]
        user.password = SecureRandom.hex(16)
        if user.save
          imported += 1
        end
      end
    end
    
    redirect_to admin_import_path, notice: "Imported #{imported} new people from Planning Center."
  end

  def create_events
    service = PlanningCenterService.new(session[:pco_access_token])
    plans = service.fetch_plans
    
    imported = 0
    plans.each do |plan_data|
      next if plan_data[:starts_at].blank?
      
      team = Team.find_or_create_by(name: plan_data[:team_name])
      
      starts_at = Time.parse(plan_data[:starts_at])
      event = Event.find_or_initialize_by(
        name: plan_data[:name],
        team: team,
        starts_at: starts_at
      )
      
      if event.new_record?
        event.ends_at = starts_at + 2.hours
        if event.save
          imported += 1
        end
      end
    end
    
    redirect_to admin_import_path, notice: "Imported #{imported} new events from Planning Center."
  end

  private

  def require_pco_connection
    unless session[:pco_access_token]
      redirect_to admin_teams_path, alert: "Please connect to Planning Center first."
    end
  end
end