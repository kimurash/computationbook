require_relative 'ski_call'
require_relative 'ski_combinator'
require_relative 'ski_symbol'

# 各コンビネータに簡約規則を実装
x = SKISymbol.new(:x)
=begin
expr = SKICall.new(
    SKICall.new(S, K),
    SKICall.new(I, x)
)
=end

y = SKISymbol.new(:y)
z = SKISymbol.new(:z)
# puts S.call(x, y, z)

# 簡約規則を適用できるか判定するメソッドを実装
=begin
expr = SKICall.new(SKICall.new(x, y), z)
puts expr.combinator.callable?(*expr.arguments)

expr = SKICall.new(SKICall.new(S, x), y)
puts expr.combinator.callable?(*expr.arguments)

expr = SKICall.new(SKICall.new(SKICall.new(S, x), y), z)
puts expr.combinator.callable?(*expr.arguments)
=end

# S[K[S[I]]][K]を簡約
swap = SKICall.new(
    SKICall.new(
        S,
        SKICall.new(
            K,
            SKICall.new(S, I)
        )
    ),
    K
)

=begin
expr = SKICall.new(SKICall.new(swap, x), y)

while expr.reducible?
    puts expr
    expr = expr.reduce
end
puts expr
=end

# #as_function_ofの振る舞いを把握(1)
=begin
original = SKICall.new(SKICall.new(S, K), I)
func = original.as_function_of(:x)
puts func.reducible?

expr = SKICall.new(func, y)
while expr.reducible?
    puts expr
    expr = expr.reduce
end
puts expr

puts expr == original
=end

# #as_function_ofの振る舞いを把握(2)
=begin
original = SKICall.new(SKICall.new(S, x), I)
func = original.as_function_of(:x)
expr = SKICall.new(func, y)

while expr.reducible?
    puts expr
    expr = expr.reduce
end;
puts expr

puts expr == original
=end

# Iコンビネータはsyntax sugar
=begin
identity = SKICall.new(SKICall.new(S, K), K)
expr = SKICall.new(identity, x)
while expr.reducible?
    puts expr
    expr = expr.reduce
end
puts expr
=end


# SをIOTAに変換して簡約
=begin
expr_S = S.to_iota
while expr_S.reducible?
    puts expr_S
    expr_S = expr_S.reduce
end
puts expr_S
=end

# KをIOTAに変換して簡約
=begin
expr_K = K.to_iota
while expr_K.reducible?
    puts expr_K
    expr_K = expr_K.reduce
end
puts expr_K
=end

# IをIOTAに変換して簡約
=begin
expr_I = I.to_iota
while expr_I.reducible?
    puts expr_I
    expr_I = expr_I.reduce
end
puts expr_I
=end

# -> S[K][K[K]]
# 構文的には明らかにIとは異なるが振る舞いは同じ

identity = SKICall.new(SKICall.new(S, K), SKICall.new(K, K))
expr = SKICall.new(identity, x)
while expr.reducible?
    puts expr
    expr = expr.reduce
end
puts expr
