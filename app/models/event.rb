class Event < ApplicationRecord
    has_many :positions
    has_many :candidates 
    has_many :members
    def to_s 
        name
      end
end
