class Referendum < ApplicationRecord
  belongs_to :event
  has_many :referendum_responses

  def to_s 
    proposal
  end
end
