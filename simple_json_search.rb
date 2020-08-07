require 'pry'
require 'json'
class SimpleJsonSearch
	JSON_DATA = JSON.load(File.open('./data.json')).freeze

	def initialize(query)
		@query = query
	end

	def call
		get_query
		check_query_in_quotes
		search
		@result
	end

	private

	def search
		@result = JSON_DATA.select { |item| item.values.join(',').match(@first_query)}
		@result = @result.select { |item| item.values.join(',').match(@second_query)} if @second_query
		if @result.empty?
			@result = JSON_DATA
			@first_query.split(' ').each do |query|
				@result = @result.select { |item| item.values.join(',').match(query)}
			end
		end
	end

	def check_query_in_quotes
		@second_query = @query.scan(/[^"|']+/).last.delete_suffix(' ') if @query.scan(/[^"|']+/).count > 1
	end

	def get_query
		@first_query = @query.scan(/[^"|']+/).first.delete_suffix(' ')
	end

end