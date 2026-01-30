class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :availabilities, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :assignments, dependent: :destroy
  has_many :events, through: :assignments

  normalizes :email_address, with: -> (e) { e.strip.downcase }
  validates :name, presence: true, on: :create

  def display_name
    name.presence || email_address
  end
end