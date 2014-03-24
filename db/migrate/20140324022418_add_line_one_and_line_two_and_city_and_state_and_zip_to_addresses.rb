class AddLineOneAndLineTwoAndCityAndStateAndZipToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :line_one, :string
    add_column :addresses, :line_two, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :zip, :string
  end
end
