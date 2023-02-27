class Vote < ApplicationRecord
  belongs_to :event
  belongs_to :candidate
  belongs_to :member
  belongs_to :position

  validate :validate_vote
  
  def validate_vote 
    @count_vote = Vote.where(position_id: position_id, member: member_id).count
    @max_vote = Position.find(position_id).vacant
    @event = Event.find(event_id)
    if @count_vote == @max_vote
      errors.add(:base,"You already voted " + @count_vote.to_s + " candidate.")
    end
    # if @event.required_complete && @count_vote < @max_vote
    #   errors.add(:base,"You have to vote " + @count_vote.to_s + " more candidate(s).")
    # end
  end
end
