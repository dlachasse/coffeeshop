module QueryTools

	def append new_parameter
		@base_url << '&' + new_parameter
	end

	def encode_query str
		URI::encode(str)
	end

	def populate_query parameters
		parameters = remove_empty_keys parameters
		keys = parameters.keys
		parameterize_query(parameters, keys)
	end

	def remove_empty_keys parameters
		parameters.delete_if { |k,v| v.nil? }
	end

	def parameterize_query(parameters, keys)
		parameters.each_pair do |key, value|
			next if value.nil?
			if keys[0] == key
				@base_url << "#{key}=#{value}"
			else
				@base_url << "&#{key}=#{value}"
			end
		end
	end
end