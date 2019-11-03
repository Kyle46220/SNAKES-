class RemoveRoleFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :role, foreign_key: true
  end
end
