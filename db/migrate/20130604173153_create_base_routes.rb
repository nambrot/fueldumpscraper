class CreateBaseRoutes < ActiveRecord::Migration
  def change
    create_table :base_routes do |t|
      t.string :origin
      t.string :destination

      t.timestamps
    end

    add_index :base_routes, [:origin, :destination], :unique => true
  end
end
