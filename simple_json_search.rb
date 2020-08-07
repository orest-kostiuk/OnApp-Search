require 'pry'
require 'json'
class SimpleJsonSearch
	JSON_DATA = JSON.load(File.open('./data.json')).freeze

	def initialize(query)
		@query = query
	end

	def call

	end
end