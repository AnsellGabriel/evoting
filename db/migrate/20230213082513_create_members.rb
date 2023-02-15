class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.references :event#, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :area
      t.boolean :voted
      t.datetime :vote_date
      t.string :station
      t.string :vote_code
      t.timestamps
    end
  end
end
