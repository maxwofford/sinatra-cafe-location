require 'sinatra'
require "sinatra/activerecord"
require './environments'
require 'pry' if ENV['RACK_ENV'] == 'development'

class Cafe < ActiveRecord::Base
	self.table_name = 'cafes'
end

get '/status' do
	"Up"
end

