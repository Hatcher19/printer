class AddXlAndXxlAndXxxlAndIvxlAndVxlAndVixlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :xl, :integer
    add_column :products, :xxl, :integer
    add_column :products, :xxxl, :integer
    add_column :products, :ivxl, :integer
    add_column :products, :vxl, :integer
    add_column :products, :vixl, :integer
  end
end
