require 'treetop'

Dir[File.expand_path('../regex') << '/*.rb'].each do |file|
    if File.basename(file) == 'inspect.rb'
        next
    end

    require file
end

Treetop.load('pattern')
parser = PatternParser.new

parse_tree = parser.parse('(a(|b))*')
pattern = parse_tree.to_ast
puts pattern

puts pattern.matches?('abaab')
puts pattern.matches?('abba')
