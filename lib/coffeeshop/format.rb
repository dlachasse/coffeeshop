class Format

	def initialize(options={})
		@source = File.open(options[:source])
		@data = JSON.parse(@source.read)
		byebug
	end

end