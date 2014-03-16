class AddOrganizationAndCustomerNameAndCustomerEmailAndCustomerPhoneToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :organization, :string
    add_column :customers, :customer_name, :string
    add_column :customers, :customer_email, :string
    add_column :customers, :customer_phone, :string
  end
end
