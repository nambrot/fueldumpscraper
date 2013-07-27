# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

BaseRoute.create :origin => "BER", :destination => "BOS"
BaseRoute.create :origin => "BOS", :destination => "BER"

Strike.create :origin => "BOS", :destination => "BER"

SearchEngine.create :identifier => :kayak, :name => "Kayak.com"
SearchEngine.create :identifier => :kayak_es, :name => "Kayak.es"
