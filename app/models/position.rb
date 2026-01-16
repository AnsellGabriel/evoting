class Position < ApplicationRecord
  belongs_to :event
  has_many :candidates
  validates_presence_of :name, :vacant

  def to_s 
    name
  end
end
