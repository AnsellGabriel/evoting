class Member < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  has_many :votes
  validates :vote_code, uniqueness: { scope: :event_id }
  validates_presence_of :name, :vote_code

  def to_s
    name
  end

  def self.ransackable_attributes(auth_object = nil)
    ["area", "created_at", "description", "event_id", "id", "name", "station", "updated_at", "vote_code", "vote_date", "voted"]
  end
end
