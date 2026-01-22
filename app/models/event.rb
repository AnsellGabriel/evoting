class Event < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :candidates, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :referendums, dependent: :destroy
  has_many :elecoms, dependent: :destroy
  has_many :votes, dependent: :destroy

  def to_s
    name
  end
end
