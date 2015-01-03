class Search < Request

	attr_reader :location, :query, :keyword, :opennow, :place_id, :radius, :endpoint, :response_format

	def initialize(options={})
		# default to portland for now
		@location = options[:location] || '45.5148,-122.6420'
		@query = options[:query]

		# default to coffee, don't really plan to search for
		# anything else...
		@keyword = options[:keyword] || 'coffee'

		# if set to true, will _only_ return places that are
		# open in results
		@opennow = options[:opennow] || nil

		# in meters, defaulting to 3.5 miles
		@radius = options[:radius] || 5632
		@endpoint = options[:type] || :nearbysearch
		@response_format = options[:response_format] || :json
		super(self)
	end

end