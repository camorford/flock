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

  private

  def get(url, params = {})
    response = HTTP.auth("Bearer #{@access_token}").get(url, params: params)
    JSON.parse(response.body)
  end
end