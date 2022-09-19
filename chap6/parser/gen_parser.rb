require 'treetop'

Dir[File.expand_path('../lambda') << '/*.rb'].each do |file|
    if File.basename(file) == 'inspect.rb'
        next
    end

    require file
end

Treetop.load('lambda_calc')
parser = LambdaCalcParser.new

parse_tree = parser.parse('-> x { x[x] }[-> y { y }]')
puts expr = parse_tree.to_ast
puts expr.reduce
