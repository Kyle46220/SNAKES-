class AddDateTimeConstraintToListings < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :created_at, :datetime, precision: 6
    change_column :listings, :updated_at, :datetime, precision: 6
  end
end
