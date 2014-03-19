class AddStyleAndColorAndQuantityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :style, :string
    add_column :products, :color, :string
    add_column :products, :quantity, :integer
  end
end
