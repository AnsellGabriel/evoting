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

  def cast_vote_record(votes)
    CSV.generate(headers: true) do |csv|
      csv << [ "Candidate", "Position", "Vote Date", "Station" ]
      votes.each do |vote|
        csv << [vote.candidate.name, vote.position.name, vote.created_at, vote.member.user_id.present? ? vote.member.user.user_name : "Online"]
      end
    end
  end

  def reset_election 
    self.members.update_all(voted: false)
    self.votes.destroy_all
    # self.elections.destroy_all
  end
end
