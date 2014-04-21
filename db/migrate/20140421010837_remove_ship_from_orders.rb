class RemoveShipFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ship, :boolean
  end
end
