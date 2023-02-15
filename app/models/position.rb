class Position < ApplicationRecord
  belongs_to :event
  validates_presence_of :name, :vacant
end
