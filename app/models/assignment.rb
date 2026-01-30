class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :position

  enum :status, {
    pending: 0,
    confirmed: 1,
    declined: 2
  }, default: :pending

  validates :user_id, uniqueness: { scope: :event_id, message: "is already assigned to this event" }
end