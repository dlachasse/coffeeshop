class ResultParser

	def initialize(response)
		@response = response
		@db = Database.new
		parse_and_save
	end

	def parse_and_save
		 # all results, regardless of method are stored in
		 # .parsed_response["results"] object
		@response.parsed_response["results"].each do |result|
			place_id = result["place_id"]
			record = @db.find_place(place_id)
			if record.nil?
				@db.save_place(place_id)
			end
		end
	end

end