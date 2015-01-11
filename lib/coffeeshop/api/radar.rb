class Radar < Request

	attr_reader :location, :query, :keyword, :opennow, :place_id, :radius, :types, :endpoint, :next_page_token, :response_format

	def initialize(options={})
		@location = options[:location] || ENV['DEFAULT_SEARCH_CENTER']
		@types = 'cafe'
		@radius = 2000
		@endpoint = :radarsearch
		@response_format = :json
		super(self)
	end

end