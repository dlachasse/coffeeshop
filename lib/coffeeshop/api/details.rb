class Details < Request

	attr_reader :place_id, :location, :query, :opennow, :keyword, :radius, :endpoint, :response_format

	def initialize(params={})
		@place_id = params[:place_id]
		@endpoint = :details
		@response_format = :json
		super(self)
	end

end