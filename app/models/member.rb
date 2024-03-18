class Member < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  validates :vote_code, uniqueness: true
  validates_presence_of :name, :vote_code
  def to_s 
    name
  end
  def self.ransackable_attributes(auth_object = nil)
    ["area", "created_at", "description", "event_id", "id", "name", "station", "updated_at", "vote_code", "vote_date", "voted"]
  end
end
