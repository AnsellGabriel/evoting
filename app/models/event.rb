class Event < ApplicationRecord
    has_many :positions
    has_many :candidates 
    has_many :members
    has_many :referendums

    def to_s 
        name
      end
end
