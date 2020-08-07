require './simple_json_search'

loop do
	puts('Input your search')
	query = gets.chomp
	break if query == 'exit'
	puts('result:')
	puts(SimpleJsonSearch.new(query).call)
	puts
end