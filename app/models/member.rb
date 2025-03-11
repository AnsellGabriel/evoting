class Member < ApplicationRecord
  belongs_to :event
<<<<<<< HEAD
  # validates :vote_code, uniqueness: true
=======
  belongs_to :user, optional: true
  has_many :votes
  validates :vote_code, uniqueness: true
>>>>>>> da9d7a1ef4359043960eb73fe683c0f2c9065165
  validates_presence_of :name, :vote_code

  def to_s
    name
  end

  def self.ransackable_attributes(auth_object = nil)
    ["area", "created_at", "description", "event_id", "id", "name", "station", "updated_at", "vote_code", "vote_date", "voted"]
  end
end
