class Search < Request

	attr_reader :location, :query, :keyword, :opennow, :place_id, :radius, :endpoint, :response_format

	def initialize(options={})
		@location = options[:location] || nil
		@query = options[:query]
		@keyword = nil
		@opennow = options[:opennow] || nil
		@radius = options[:radius] || 5
		@endpoint = options[:type] || :textsearch
		@response_format = options[:response_format] || :json
		super(self)
	end

end