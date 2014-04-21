class AddUuidToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :uuid, :integer
  end
end
