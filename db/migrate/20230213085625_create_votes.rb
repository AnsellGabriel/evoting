class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :event, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.decimal :vote_amount, precision: 18, scale: 2
      t.string :station

      t.timestamps
    end
  end
end
