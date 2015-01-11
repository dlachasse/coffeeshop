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
		@types = query_parameters.types
		@next_page_token = query_parameters.next_page_token
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
			"types" => @types,
			"pagetoken" => @next_page_token,
			"key" => ENV['API_KEY']
		}
		populate_query(query_parameters)
		encode_query
	end

	def encode_query
		URI::encode(@base_url)
	end

	def set_api_endpoint
		if @endpoint.nil?
			@base_url << 'nearbysearch/'
		else
			@base_url << "#{@endpoint.to_s}/"
		end
	end

	def set_response_format
		if @response_format == :xml
			@base_url << 'xml?'
		else
			@base_url << 'json?'
		end
	end

end