class Event < ApplicationRecord
    has_many :positions
    has_many :candidates 
    has_many :members

end
