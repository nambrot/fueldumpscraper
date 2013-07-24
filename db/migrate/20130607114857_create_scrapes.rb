class CreateScrapes < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.text :base_route_ids
      t.text :strike_ids
      t.string :date_string
      t.text :search_engine_ids

      t.timestamps
    end
  end
end
