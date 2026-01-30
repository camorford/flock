class PlanningCenterService
  def initialize(access_token)
    @access_token = access_token
  end

  def configured?
    @access_token.present?
  end

  def fetch_teams
    response = get("https://api.planningcenteronline.com/services/v2/teams")
    return [] unless response["data"]
    
    response["data"].map do |team|
      {
        pco_id: team["id"],
        name: team["attributes"]["name"]
      }
    end
  end

  def fetch_people
    response = get("https://api.planningcenteronline.com/people/v2/people", per_page: 100)
    return [] unless response["data"]
    
    response["data"].map do |person|
      {
        pco_id: person["id"],
        name: "#{person['attributes']['first_name']} #{person['attributes']['last_name']}".strip,
        email: person["attributes"].dig("primary_contact_method", "value") || person["attributes"]["login_identifier"]
      }
    end
  end

  def fetch_plans
    service_types_response = get("https://api.planningcenteronline.com/services/v2/service_types")
    return [] unless service_types_response["data"]
    
    plans = []
    service_types_response["data"].each do |service_type|
      plans_response = get("https://api.planningcenteronline.com/services/v2/service_types/#{service_type['id']}/plans", per_page: 25)
      next unless plans_response["data"]
      
      plans_response["data"].each do |plan|
        plans << {
          pco_id: plan["id"],
          name: plan["attributes"]["title"].presence || service_type["attributes"]["name"],
          service_type: service_type["attributes"]["name"],
          starts_at: plan["attributes"]["sort_date"],
          team_name: service_type["attributes"]["name"]
        }
      end
    end
    
    plans.sort_by { |p| p[:starts_at] }.reverse.first(20)
  end

  private

  def get(url, params = {})
    response = HTTP.auth("Bearer #{@access_token}").get(url, params: params)
    JSON.parse(response.body)
  end
end