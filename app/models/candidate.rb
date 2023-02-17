class Candidate < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :position
  # validates_presences_of :name
  validates_presence_of :name
  has_one_attached :picture
end
