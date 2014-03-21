class AddFileAndColorAndLocationToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :file, :string
    add_column :artworks, :color, :string
    add_column :artworks, :location, :string
  end
end
