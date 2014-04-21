class AddShipTypeToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :ship_type, :string
  end
end
