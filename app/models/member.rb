class Member < ApplicationRecord
  belongs_to :event

 
  def to_s 
    name
  end
  def self.ransackable_attributes(auth_object = nil)
    ["area", "created_at", "description", "event_id", "id", "name", "station", "updated_at", "vote_code", "vote_date", "voted"]
  end
end
