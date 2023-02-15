class Election < ApplicationRecord
  belongs_to :member, optional: true
  # validates :voter_code, presence :true
  validates_presence_of :voter_code, :station
end
