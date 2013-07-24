class CreatePricedBaseRoutes < ActiveRecord::Migration
  def change
    create_table :priced_base_routes do |t|
      t.date :start_date
      t.date :end_date
      t.float :price
      t.string :currency
      t.integer :search_engine_id
      t.integer :base_route_id

      t.timestamps
    end
  end
end
