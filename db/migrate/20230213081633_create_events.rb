class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.boolean :required_complete
      t.boolean :allow_single
      t.boolean :active
      t.boolean :election

      t.timestamps
    end
  end
end
