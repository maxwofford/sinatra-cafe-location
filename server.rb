require 'sinatra'
require "sinatra/activerecord"
require 'geocoder'
require './environments'
require 'pry' if ENV['RACK_ENV'] == 'development'

# Model
class Cafe < ActiveRecord::Base
	extend Geocoder::Model::ActiveRecord
	self.table_name = 'cafes' #'cafe'.pluralize defaults to 'caves'

	geocoded_by :full_address 
	after_validation :geocode

	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode  

	def full_address
		"#{address}, #{zipcode}, #{city}, #{country}"
	end
end

# Routes
get '/api/status' do
	"Up"
end

get '/api/cafe/:id' do
	if Cafe.find(params[:id])	
		Cafe.find(params[:id]).to_json
	else
		"Cafe not found"
	end
end

get '/api/location/:lat/:lng/:distance' do
	# Find cafe id by geocoding
	@local_cafes = Cafe.near('#{params[:lat]},#{params[:lng]}', params[:distance])
	@local_cafes.to_json
end

get '/api/location/:lat/:lng' do
	# Find cafe id by geocoding
	@local_cafes = Cafe.near('#{params[:lat]},#{params[:lng]}', 5)
	@local_cafes.to_json
end

post '/api/cafe' do
	Cafe.create.from_json(params[:post])
end
