class CreateReferendums < ActiveRecord::Migration[7.0]
  def change
    create_table :referendums do |t|
      t.references :event, null: false, foreign_key: true
      t.string :proposal
      t.boolean :active

      t.timestamps
    end
  end
end
