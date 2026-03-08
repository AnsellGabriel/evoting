class AddGraphOnlyToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :graph_only, :boolean, default: false
  end
end
