class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :position

  validates :user_id, uniqueness: { scope: [:team_id, :position_id], message: "already has this position on this team" }
end