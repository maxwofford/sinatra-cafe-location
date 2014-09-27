require 'sinatra'
require "sinatra/activerecord"
require './environments'
require 'pry'

class Cafe < ActiveRecord::Base
	self.table_name = 'cafes'
end

get '/status' do
	binding.pry
	"Up"
end

