class AddDestroyedAtToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :destroyed_at, :datetime
  end
end
