class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.references :event, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.string :name
      t.string :remark

      t.timestamps
    end
  end
end
