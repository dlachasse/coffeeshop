require 'grape'
require 'dotenv'
require 'httparty'
require 'open-uri'
require 'rack'

Dotenv.load

require_relative 'coffeeshop/query_tools'
require_relative 'coffeeshop/request'
require_relative 'coffeeshop/query'
require_relative 'coffeeshop/api/search'
require_relative 'coffeeshop/api/details'

module Coffeeshop

	class API < Grape::API

		version 'v1', using: :path
		format :json
		prefix :api

		helpers do

			def search(params={})
				Search.new(params).send_query
			end

			def details(params={})
				Details.new(params).send_query
			end

		end

		desc 'List of places close to location'
		params do
      optional :location, type: String, desc: "Geolocation coordinates"
      optional :query, type: String, desc: "Query string for text search"
      optional :keyword, type: String, desc: "Keyword for nearby search"
      optional :opennow, type: String, desc: "Only returns currently open locations"
      optional :radius, type: Integer, desc: "Search radius in miles"
      optional :endpoint, type: String, desc: "Specifies text or nearby search"
      optional :response_format, type: String, desc: "Response format"
   	end
		get :places do
			places = search(declared(params))
			return places
		end

		desc 'Details about specific location'
		params do
			requires :place_id, type: String, desc: "Google's proprietary place_id"
		end
		get :details do
			details = details(declared(params))
			return details
		end

	end

end
