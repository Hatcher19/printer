class AddEndDateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :end_date, :date
  end
end
