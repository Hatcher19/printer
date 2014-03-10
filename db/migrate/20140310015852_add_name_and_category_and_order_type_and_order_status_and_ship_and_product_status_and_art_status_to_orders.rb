class AddNameAndCategoryAndOrderTypeAndOrderStatusAndShipAndProductStatusAndArtStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :category, :string
    add_column :orders, :order_type, :string
    add_column :orders, :order_status, :string
    add_column :orders, :ship, :boolean
    add_column :orders, :product_status, :string
    add_column :orders, :art_status, :string
  end
end
