class AddUserToMember < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :user
  end
end
