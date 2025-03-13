class AddMinVoteToElection < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :min_vote, :boolean
    add_column :positions, :min_vote, :integer
  end
end
