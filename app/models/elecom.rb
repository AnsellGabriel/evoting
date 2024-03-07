class Elecom < ApplicationRecord
    belongs_to :event, optional: true

    validates_presence_of :name
end
