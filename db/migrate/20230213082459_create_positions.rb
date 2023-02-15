class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.integer :vacant

      t.timestamps
    end
  end
end
