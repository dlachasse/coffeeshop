class Database

	attr_accessor :db

	def initialize
		@db = Sequel.connect('sqlite://places.db')
	end

	def create_database_schema
		@db.create_table :places do
		  primary_key :id
		  String :place_id
		end
	end

end