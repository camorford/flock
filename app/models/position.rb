class Position < ApplicationRecord
  belongs_to :team
  has_many :team_memberships, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
end