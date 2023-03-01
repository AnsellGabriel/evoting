class Election < ApplicationRecord
  belongs_to :member, optional: true
  # validates :voter_code, presence :true
  validates_presence_of :voter_code

  def check_votercode
    @event = Event.findy_by(active: 1)
    @member = Member.find_by(event: @event voter_code: voter_code)
    unless @event.election 
      errors.add(:base,"Election is now close")   
    end
    if @member.nil?
      errors.add(:base,"Voter code not valid")   
    else
      if @member.voted
        errors.add(:base,"Cooperative already voted")
      end
    end
    
  end
end
