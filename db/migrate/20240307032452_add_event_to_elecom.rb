class AddEventToElecom < ActiveRecord::Migration[7.0]
  def change
    add_reference :elecoms, :event
  end
end
