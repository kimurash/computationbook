require 'treetop'

require_relative '../ski_call'
require_relative '../ski_combinator'
require_relative '../ski_symbol'

require_relative 'lc_call'
require_relative 'lc_function'
require_relative 'lc_variable'


Treetop.load('lambda_calc')
parser = LambdaCalcParser.new

# ラムダ計算をSKI計算に変換
two = parser.parse('-> p { -> x { p[p[x]] } }').to_ast
# puts two.to_ski

inc = SKISymbol.new(:inc)
zero = SKISymbol.new(:zero)

=begin
expr = SKICall.new(SKICall.new(two.to_ski, inc), zero)
while expr.reducible?
    puts expr
    expr = expr.reduce
end
puts expr
=end

=begin
ラムダ計算の式をSKI計算を通してIotaに変換し,
それを評価して振る舞いを確認する
=end

expr = SKICall.new(SKICall.new(two.to_ski.to_iota, inc), zero)
expr = expr.reduce while expr.reducible?
puts expr
