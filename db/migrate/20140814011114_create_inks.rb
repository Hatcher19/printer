class CreateInks < ActiveRecord::Migration
  def change
    create_table :inks do |t|

      t.timestamps
    end
  end
end
