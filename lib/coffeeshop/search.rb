class Search < Request

	def initalize(type, query)
		super
		@type = type
		@query = query
		build_query
	end

	def build_query
		set_type
		append_key
	end

	def set_type
		if @type == :text
			@base_url += 'textsearch/'
		else
			@base_url += 'nearbysearch/' + location
		end
	end

	def get_coords
		'45.5200,122.6819' # set to Portland for now
	end

	def location
		'location=' += get_coords
	end

	def radius
		'radius=5'
	end

end