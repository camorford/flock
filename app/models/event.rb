class Event < ApplicationRecord
  belongs_to :team
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :ends_at_after_starts_at

  private

  def ends_at_after_starts_at
    return unless starts_at && ends_at
    if ends_at <= starts_at
      errors.add(:ends_at, "must be after start time")
    end
  end
end