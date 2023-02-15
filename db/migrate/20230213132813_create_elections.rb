class CreateElections < ActiveRecord::Migration[7.0]
  def change
    create_table :elections do |t|
      t.references :member#, null: false, foreign_key: true
      t.string :voter_code
      t.string :station
      t.timestamps
    end
  end
end
