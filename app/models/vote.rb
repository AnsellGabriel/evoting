class Vote < ApplicationRecord
  belongs_to :event
  belongs_to :candidate
  belongs_to :member
  belongs_to :position

  validate :validate_vote
  
  def validate_vote 
    @count_vote = Vote.where(position_id: position_id, member: member_id).count
    @max_vote = Position.find(position_id).vacant
    if @count_vote == @max_vote
      errors.add(:base,"You already voted " + @count_vote.to_s + " candidate.")
    end
  end
end
