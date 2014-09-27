require 'sinatra'
require "sinatra/activerecord"
require './environments'
require 'pry' if ENV['RACK_ENV'] == 'development'

class Cafe < ActiveRecord::Base
	self.table_name = 'cafes'
end

get '/api/status' do
	"Up"
end

get '/api/cafe/:id' do
	Cafe.find(params[:id]).to_json
end

post '/api/cafe' do
	Cafe.create.from_json(params[:post])
end