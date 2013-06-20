class CreateStrikes < ActiveRecord::Migration
  def change
    create_table :strikes do |t|
      t.string :origin
      t.string :destination

      t.timestamps
    end
    add_index :strikes, [:origin, :destination], :unique => true
  end
end
