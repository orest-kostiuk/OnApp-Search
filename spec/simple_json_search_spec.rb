require './simple_json_search'
describe SimpleJsonSearch do
	let(:json_search) { SimpleJsonSearch.new(query) }

	context 'search by name' do
		let(:query) { 'Common Lisp' }
		let(:response) {[
			{
        'Name': 'Common Lisp',
        'Type': 'Compiled, Interactive mode, Object-oriented class-based, Reflective',
        'Designed by': 'Scott Fahlman, Richard P. Gabriel, Dave Moon, Guy Steele, Dan Weinreb'
      }
		]}

		it 'Common Lisp' do
			expect(json_search.call).to eql(response)
		end
	end

	context 'search with quotes' do
		let(:query) { 'Interpreted "Thomas Eugene"' }
		let(:bas) {[
			{
				'Name': 'BASIC',
				'Type': 'Imperative, Compiled, Procedural, Interactive mode, Interpreted',
				'Designed by': 'John George Kemeny, Thomas Eugene Kurtz'
			}
		]}
		let(:has) {[
			{
				'Name': 'Haskell',
				'Type': 'Compiled, Functional, Metaprogramming, Interpreted, Interactive mode',
				'Designed by': "Simon Peyton Jones, Lennart Augustsson, Dave Barton, Brian Boutel, Warren Burton, Joseph Fasel,
											  Kevin Hammond, Ralf Hinze, Paul Hudak, John Hughes, Thomas Johnsson, Mark Jones,
											  John Launchbury, Erik Meijer, John Peterson, Alastair Reid, Colin Runciman, Philip Wadler"
			}
		]}

		it 'Interpreted "Thomas Eugene"' do
			expect(json_search.call ).to eql(bas)
		end

		it 'Interpreted "Thomas Eugene" not eql Haskell' do
			expect(json_search.call ).to eql(has)
		end
	end

	context 'search by different keys' do
		let(:query) { 'Scripting Microsoft' }
		let(:js) {{
			'Name': 'JScript',
			'Type': 'Curly-bracket, Procedural, Reflective, Scripting',
			'Designed by': 'Microsoft'
		}}
		let(:vb) {{
			'Name': 'VBScript',
			'Type': 'Interpreted, Procedural, Scripting, Object-oriented class-based',
			'Designed by': 'Microsoft'
		}}
		let(:wp) {{
			'Name': 'Windows PowerShell',
			'Type': 'Command line interface, Curly-bracket, Interactive mode, Interpreted, Scripting',
			'Designed by': 'Microsoft'
		}}
		it 'Scripting Microsoft' do
			expect(json_search.call).to eql([js, vb, wp])
		end
	end

	context 'filter' do
		let(:query) { 'john --array' }
		let(:bas) {{
			'Name':  'BASIC',
			'Type':  'Imperative, Compiled, Procedural, Interactive mode, Interpreted',
			'Designed by':  "John George Kemeny, Thomas Eugene Kurtz"
		}}
		let(:has) {{
			'Name':  'Haskell',
			'Type':  'Compiled, Functional, Metaprogramming, Interpreted, Interactive mode',
			'Designed by':  'Simon Peyton Jones, Lennart Augustsson, Dave Barton, Brian Boutel, Warren Burton, Joseph Fasel, Kevin Hammond, Ralf Hinze, Paul Hudak, John Hughes, Thomas Johnsson, Mark Jones, John Launchbury, Erik Meijer, John Peterson, Alastair Reid, Colin Runciman, Philip Wadler'
		}}
		let(:lis) {{
			'Name':  'Lisp',
			'Type':  'Metaprogramming, Reflective',
			'Designed by':  'John McCarthy'
		}}
		let(:s) {{
			'Name':  'S-Lang',
			'Type':  'Curly-bracket, Interpreted, Procedural, Scripting, Interactive mode',
			'Designed by':  'John E. Davis'
		}}
		it 'john --array' do
			expect(json_search.call).to eql([bas, has, lis, s])
		end
	end
end
