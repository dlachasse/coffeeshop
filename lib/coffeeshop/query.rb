class Query < Request

	attr_reader :base_url
	include QueryTools

	def initialize(query_parameters)
		@place_id = query_parameters.place_id
		@location = query_parameters.location
		@keyword = query_parameters.keyword
		@query = query_parameters.query
		@radius = query_parameters.radius
		@endpoint = query_parameters.endpoint
		@opennow = query_parameters.opennow
		@response_format = query_parameters.response_format
		@base_url = 'https://maps.googleapis.com/maps/api/place/'
	end

	def build_uri_parameters
		set_api_endpoint
		set_response_format
		query_parameters = {
			"location" => @location,
			"keyword" => @keyword,
			"radius" => @radius,
			"query" => @query,
			"opennow" => @opennow,
			"placeid" => @place_id,
			"key" => ENV['API_KEY']
		}
		populate_query(query_parameters)
		encode_query
	end

	def encode_query
		URI::encode(@base_url)
	end

	def set_api_endpoint
		case @endpoint
			when :textsearch
				@base_url << 'textsearch/'
			when :nearbysearch
				@base_url << 'nearbysearch/'
			when :details
				@base_url << 'details/'
		end
	end

	def set_response_format
		if @response_format == :json
			@base_url << 'json?'
		else
			@base_url << 'xml?'
		end
	end

end