class Election < ApplicationRecord
  belongs_to :member, optional: true
  # validates :voter_code, presence :true
  validates_presence_of :voter_code
  validate :check_votercode

  def check_votercode
    @event = Event.find_by(active: 1)
    @member = @event.members.find_by(vote_code: voter_code)
    # @member = Member.find_by(event: @event, vote_code: voter_code)
    # raise "errors"
    unless @event.election
      errors.add(:base, "Election is now close")
    end
    if @member.nil?
      errors.add(:base, "Voter code not valid")
    else
      if @member.voted?
        if @member.user_id.present?
          errors.add(:base, "Member already voted to #{@member.user.user_name}")
        else
          errors.add(:base, "Member already voted")
        end
      end
    end
  end
end
