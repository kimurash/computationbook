require 'treetop'

=begin
用途に応じてexpand_path()の引数を書き換える
- スモールステップ意味論 '../small_step'
- ビッグステップ意味論   '../big_step'
- 表示的意味論         '../denotational'
=end
Dir[File.expand_path('../denotational') << '/*.rb'].each do |file|
    if File.basename(file) == 'inspect.rb'
        next
    end

    require file
end

Treetop.load('simple')
parser = SimpleParser.new
parse_tree = parser.parse('while (x < 5) { x = x * 3 }')
sttmt = parse_tree.to_ast
# puts sttmt

puts sttmt.to_ruby
