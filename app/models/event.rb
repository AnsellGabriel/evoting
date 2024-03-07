class Event < ApplicationRecord
    has_many :positions
    has_many :candidates 
    has_many :members
    has_many :referendums
    has_many :elecoms

    def to_s 
        name
      end
end
