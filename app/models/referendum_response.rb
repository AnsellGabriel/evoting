class ReferendumResponse < ApplicationRecord
  belongs_to :member
  belongs_to :referendum
  # validates_presence_of :response
  validates :response, inclusion: { in: [true, false] }
end
