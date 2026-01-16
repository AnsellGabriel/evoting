class Member < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  has_many :votes

  before_validation :generate_vote_code, :default_values, on: :create
  validates :vote_code, uniqueness: { scope: :event_id }
  validates_presence_of :name, :vote_code

  def to_s
    name
  end

  def self.to_csv(members)
    CSV.generate(headers: true) do |csv|
      csv << ["Name", "Description", "Voted", "Vote Date", "Station", "Vote Code"]
      members.each do |member|
        csv << [member.name, member.description, member.voted, member.vote_date, member.station, member.vote_code]
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["area", "created_at", "description", "event_id", "id", "name", "station", "updated_at", "vote_code", "vote_date", "voted"]
  end

  private 

  def generate_vote_code
    code = SecureRandom.alphanumeric(4).upcase
    modified_string = code.gsub(/[1iO0I]/, "A")
    self.vote_code = modified_string
  end

  def default_values 
    self.voted = false
    self.vote_date = nil
    self.station = nil
  end
end
