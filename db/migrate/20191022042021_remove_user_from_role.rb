class RemoveUserFromRole < ActiveRecord::Migration[5.2]
  def change
    remove_column :roles, :user_id
  end
end
