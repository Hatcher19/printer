class AddOrderIdToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :order_id, :integer
  end
end
