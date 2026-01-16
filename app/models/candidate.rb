class Candidate < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :position
  has_many :votes
  # validates_presences_of :name
  validates_presence_of :name
  has_one_attached :picture

  def to_s 
    name
  end
end
