Dir[File.expand_path('../pushdown_automata') << '/*.rb'].each do |file|
    if File.basename(file) == 'inspect.rb'
        next
    end

    require file
end

require_relative '../lexer/lexer'

start_rule = PDARule.new(1, nil, 2, '$', ['S', '$'])

symbol_rules =[
    # statement ::= while | assign
    PDARule.new(2, nil, 2, 'S', ['W']),
    PDARule.new(2, nil, 2, 'S', ['A']),

    # while ::= 'w' '(' expression ')' '{' statement '}'
    PDARule.new(2, nil, 2, 'W', ['w', '(', 'E', ')', '{', 'S', '}']),

    # assign ::= 'v' '=' expression
    PDARule.new(2, nil, 2, 'A', ['v', '=', 'E']),

    # expression ::= less-than
    PDARule.new(2, nil, 2, 'E', ['L']),

    # less-than ::= multiply '<' less-than | multiply
    PDARule.new(2, nil, 2, 'L', ['M', '<', 'L']),
    PDARule.new(2, nil, 2, 'L', ['M']),

    # multiply ::= term '*' multiply | term
    PDARule.new(2, nil, 2, 'M', ['T', '*', 'M']),
    PDARule.new(2, nil, 2, 'M', ['T']),

    # term ::= 'n' | 'v'
    PDARule.new(2, nil, 2, 'T', ['n']),
    PDARule.new(2, nil, 2, 'T', ['v'])
]

token_rules =
    LexicalAnalyzer::GRAMMAR.map do |rule|
        PDARule.new(2, rule[:token], 2, rule[:token], [])
    end

stop_rule = PDARule.new(2, nil, 3, '$', ['$'])

rulebook = NPDARulebook.new([start_rule, stop_rule] + symbol_rules + token_rules)
npda_design = NPDADesign.new(1, '$', [3], rulebook)
token_string = LexicalAnalyzer.new('while (x < 5) { x = x * 3 }').analyze.join
puts npda_design.accepts?(token_string)

token_string = LexicalAnalyzer.new('while (x < 5 x = x * }').analyze.join
puts npda_design.accepts?(token_string)
