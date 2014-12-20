class Request

	def initialize
		@base_url = 'https://maps.googleapis.com/maps/api/place/'
	end

	def append_key
		@base_url = @base_url + ENV['API_KEY']
	end

end