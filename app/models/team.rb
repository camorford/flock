class Team < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
  has_many :events, dependent: :destroy

  validates :name, presence: true
end