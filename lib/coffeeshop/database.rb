class Database

	attr_accessor :db

	def initialize
		@db = Sequel.connect('sqlite://places.db')
		validate_schema
	end

	def validate_schema
		if @db.tables.empty?
			create_database_schema
		else
			@db = @db[:places]
		end
	end

	def create_database_schema
		@db.create_table :places do
		  primary_key :id
		  String :place_id
		end
		validate_schema
	end

	def find_place(place_id)
		@db[place_id: place_id]
	end

	def save_place(place_id)
		@db.insert(place_id: place_id)
	end

	def load_all_places
		@db.select(:place_id)
	end

end