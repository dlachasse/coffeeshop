class Details < Request

	attr_reader :place_id, :location, :query, :opennow, :keyword, :radius, :types, :endpoint, :response_format, :next_page_token

	def initialize(params={})
		@place_id = params[:place_id]
		@endpoint = :details
		@response_format = :json
		super(self)
	end

end