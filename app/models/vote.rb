class Vote < ApplicationRecord
  belongs_to :event
  belongs_to :candidate
  belongs_to :member
  belongs_to :position
end
