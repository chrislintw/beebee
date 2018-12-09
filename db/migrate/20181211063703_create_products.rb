class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price, unsigned: true
      t.integer :discount, unsigned: true
      t.references :created_by, table_name: :users, null: false

      t.timestamps
    end
  end
end
