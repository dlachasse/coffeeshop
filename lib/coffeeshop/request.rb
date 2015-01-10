class Request

	attr_accessor :base_url

	def initialize(query_params)
		@query_parameters = query_params
	end

	def send_query
		query = Query.new(@query_parameters)
		url = query.build_uri_parameters
		puts url
		response = HTTParty.get(url)
	end

end