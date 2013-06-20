class CreateSearchEngines < ActiveRecord::Migration
  def change
    create_table :search_engines do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end

    add_index :search_engines, :identifier, :unique => true
  end
end
