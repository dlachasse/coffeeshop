require 'dotenv'
require 'httparty'
require 'open-uri'
require 'active_support'
require 'byebug'
require 'json'
require 'sequel'
require 'sqlite3'

Dotenv.load

require_relative 'coffeeshop/query_tools'
require_relative 'coffeeshop/request'
require_relative 'coffeeshop/query'
require_relative 'coffeeshop/format'
require_relative 'coffeeshop/database'
require_relative 'coffeeshop/result_parser'
require_relative 'coffeeshop/api/search'
require_relative 'coffeeshop/api/details'
require_relative 'coffeeshop/api/radar'
require_relative 'coffeeshop/city/portland'

module Coffeeshop

	class << self

		def search(params={})
			@places = Search.new(params).send_query
			write_places_results
		end

		def details(params={})
			@details = Details.new(params).send_query
		end

		def radar(params={})
			@radar = Radar.new(params).send_query
			ResultParser.new(@radar)
		end

		def write_results
			if valid_details_request?
				@details = @details.parsed_response["result"]
				unless @details["name"] == 'Starbucks'
					File.open('./results.json', 'a+') do |file|
						place = remove_unused_detail_properties
						file.write(place.to_json + ",")
					end
				end
			end
		end

		def valid_details_request?
			@details.parsed_response["status"] != 'INVALID_REQUEST'
		end

		def scan_places
			contents = JSON.parse(File.read('./places.json'))
			contents.each do |place|
				details({ place_id: place["place_id"] })
				place["details"] = remove_unused_detail_properties(@details.parsed_response["result"])
				write_complete_results place
			end
			format_output 'results'
		end

		def write_complete_results place
			File.open('./results.json', 'a+') do |file|
				place = remove_unused_place_properties(place)
				file.write(place.to_json + ",")
			end
		end

		def remove_unused_detail_properties
			unused_properties = ["address_components", "id", "icon", "international_phone_number", "reference", "scope", "types", "price_level"]
			@details.reject { |k,v| unused_properties.include?(k) }
		end

		def remove_unused_place_properties place
			unused_properties = ["icon", "id", "reference", "scope", "types"]
			place.reject { |k,v| unused_properties.include?(k) }
		end

		def check_for_more_results
			next_page_token = @places.parsed_response.fetch("next_page_token", nil)
			unless next_page_token.nil?
				sleep(10.seconds)
				search({ next_page_token: next_page_token })
				check_for_more_results
			end
		end

		def write_places_results
			File.open('./places.json','a+') do |file|
				@places.parsed_response["results"].each do |place|
					file.write "#{place.to_json},"
				end
			end
		end

		def format_output file
			file_name = "./#{file}.json"
			snip_trailing_comma file_name
			wrap_object_in_array file_name
		end

		def snip_trailing_comma file_name
			File.truncate(file_name, File.size(file_name) - 1)
		end

		def wrap_object_in_array file_name
			contents = File.read(file_name)
			contents = contents.gsub(/\A/,'[')
			contents = contents.gsub(/\z/,']')
			File.open(file_name, 'w') { |file| file.puts contents }
		end

		def load_coords
			Portland::LOCATIONS
		end

		def load_place_ids
			@db = Database.new.load_all_places
		end

		def get_places params
			search(params)
			check_for_more_results
			format_output 'places'
		end

		def get_details params, output=false
			place_ids = load_place_ids
			place_ids.each do |place|
				details(params.merge!(place_id: place[:place_id]))
				write_results if output
			end
			format_output('results.json') if output
		end

		def get_radar params
			coords = load_coords
			coords.each do |coord|
				radar(params.merge!(location: coord))
			end
		end

	end

end
