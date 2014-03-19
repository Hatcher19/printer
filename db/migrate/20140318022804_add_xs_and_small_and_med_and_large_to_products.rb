class AddXsAndSmallAndMedAndLargeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :xs, :integer
    add_column :products, :small, :integer
    add_column :products, :med, :integer
    add_column :products, :large, :integer
  end
end
