class CreateElecoms < ActiveRecord::Migration[7.0]
  def change
    create_table :elecoms do |t|
      t.string :name
      t.string :position

      t.timestamps
    end
  end
end
