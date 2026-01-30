class PlanningCenterAuthController < ApplicationController
  def connect
    client_id = Rails.application.credentials.dig(:planning_center, :client_id)
    redirect_uri = planning_center_callback_url
    scope = "people services"
    
    auth_url = "https://api.planningcenteronline.com/oauth/authorize?" + {
      client_id: client_id,
      redirect_uri: redirect_uri,
      response_type: "code",
      scope: scope
    }.to_query
    
    redirect_to auth_url, allow_other_host: true
  end

  def callback
    code = params[:code]
    
    response = HTTP.post("https://api.planningcenteronline.com/oauth/token", form: {
      grant_type: "authorization_code",
      code: code,
      client_id: Rails.application.credentials.dig(:planning_center, :client_id),
      client_secret: Rails.application.credentials.dig(:planning_center, :client_secret),
      redirect_uri: planning_center_callback_url
    })
    
    if response.status.success?
      tokens = JSON.parse(response.body)
      session[:pco_access_token] = tokens["access_token"]
      session[:pco_refresh_token] = tokens["refresh_token"]
      redirect_to admin_teams_path, notice: "Connected to Planning Center!"
    else
      redirect_to admin_teams_path, alert: "Failed to connect to Planning Center."
    end
  end
end