require 'pry'
require 'json'
class SimpleJsonSearch

	attr_reader :result

	def initialize(query)
		@query = query
	end

	def call
		get_query
		get_query_in_quotes
		search
		@result
	end

	private

	def search
		query('json_data', @search_value)
		query('result', @query_in_quotes) if @query_in_quotes
		search_by_different_keys if @result.empty?
	end

	def search_by_different_keys
		@result = json_data
		@search_value.split(' ').each do |query|
			query('result', query)
		end
	end

	def get_query_in_quotes
		@query_in_quotes = @query.scan(/[^"|']+/)[1].delete_suffix(' ') if @query.scan(/[^"|']+/).count > 1
	end

	def get_query
		@search_value = @query.scan(/[^"|']+/).first.delete_suffix(' ')
	end

	def query(data, query)
		@result = __send__(data).select { |item| item.values.join(',').match(query)}
	end

	def json_data
		JSON.load(File.open('./data.json'))
	end

end