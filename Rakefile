require "bundler/gem_tasks"
require_relative 'lib/coffeeshop'

desc 'Parse data'
task :data do
	Coffeeshop.scan_places
end

desc 'Search places'
task :search, [:location, :query, :keyword, :opennow, :radius, :endpoint, :response_format] do |t, args|
	args.with_defaults(location: nil, query: nil, keyword: nil, opennow: nil, radius: nil, endpoint: nil, response_format: nil)
	Coffeeshop.get_places(args)
end

namespace :db do

	desc 'Create base database'
	task :create do
		puts "MUST HIT CTRL-D, this will hang in the console but it's actually being created. I promise."
		`sqlite3 places.db`
	end

	desc 'Create database schema'
	task :schema do
		Database.new().create_database_schema
	end

	desc 'Interact with database'
	task :interact do
		Database.new
	end

end