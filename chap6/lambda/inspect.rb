require_relative 'call'
require_relative 'function'
require_relative 'variable'

# 変数の置き換え
# (1)変数のみの式
# expr = Variable.new(:x)
# puts expr.replace(:x, Function.new(:y, Variable.new(:y)))
# puts expr.replace(:z, Function.new(:y, Variable.new(:y)))

# (2)関数の呼び出し
=begin
expr = Call.new(
    Call.new(
        Call.new(
            Variable.new(:a),
            Variable.new(:b)
        ),
        Variable.new(:c)
    ),
    Variable.new(:b)
)
puts expr
expr = expr.replace(:a, Variable.new(:x))
expr = expr.replace(:b, Function.new(:x, Variable.new(:x)))
puts expr
=end

# (3)関数
=begin
expr = Function.new( # 引数yで関数xを呼び出す
        :y,
        Call.new(Variable.new(:x), Variable.new(:y))
    )
puts expr
expr = expr.replace(:x, Variable.new(:z))
# 束縛変数は置き換えない
expr = expr.replace(:y, Variable.new(:z))
puts expr
=end

=begin
expr = Call.new( # x[y][ ->y { y[x] } ]
    Call.new(
        Variable.new(:x),
        Variable.new(:y)
    ),
    Function.new(
        :y,
        Call.new(
            Variable.new(:y),
            Variable.new(:x)
        )
    )
)
puts expr
expr = expr.replace(:x, Variable.new(:z))
expr = expr.replace(:y, Variable.new(:z))
puts expr
=end

# 自由変数を含んだ置き換え
=begin
expr = Function.new(
    :x,
    Call.new(
        Variable.new(:x), 
        Variable.new(:y)
    )
)
puts expr
replacement = Call.new(Variable.new(:z), Variable.new(:x))
expr = expr.replace(:y, replacement)
puts expr

# 関数引数により補足される
expr = expr.replace(:x, Variable.new(:a))
puts expr

# 呼び出すと置き換えられる
expr = expr.call(Variable.new(:a))
puts expr
=end

# 関数呼び出し
=begin
func = Function.new(
    :x,
    Function.new(
        :y,
        Call.new(
            Variable.new(:x),
            Variable.new(:y)
        )
    )
)
puts func
argument = Function.new(:z, Variable.new(:z))
body = func.call(argument)
puts body
=end

# 式の簡約
# -> x { p[x] }
one = Function.new(
    :p,
    Function.new(
        :x,
        Call.new(
            Variable.new(:p),
            Variable.new(:x)
        )
    )
)

# -> n { -> p { -> x { p[n[p][x]] } } }
increment = Function.new(
    :n,
    Function.new(
        :p,
        Function.new(
            :x,
            Call.new(
                Variable.new(:p),
                Call.new(
                    Call.new(
                        Variable.new(:n),
                        Variable.new(:p)
                    ),
                    Variable.new(:x)
                )
            )
        )
    )
)

# -> m { -> n { n[INCREMENT][m] } }
add = Function.new(
    :m,
    Function.new(
        :n,
        Call.new(
            Call.new(
                Variable.new(:n),
                increment
            ),
            Variable.new(:m)
        )
    )
)

expr = Call.new(Call.new(add, one), one)
while expr.reducible?
    # puts expr
    expr = expr.reduce
end
# puts expr

# expect -> p { -> x { p[p[x]] } }
# but, -> p { -> x { p[-> p { -> x { p[x] } }[p][x]] } }

=begin
reducile?がtrueである限りループし続ける構造になっているが,
Functionはreducible?でないため簡約が止まってしまう.

関数本体の簡約を実行するような評価戦略(作用的順序や正規順序)
を使って#reduceを再実装することで修正できる.

見かけは異なるが,外延的等価性により数2と等価とみなせる.
=end

# -> p {-> x { p[x] } }[p]を簡約してみる
=begin
expr_test = Call.new(
    Function.new(
        :p, 
        Function.new(
            :x,
            Call.new(
                Variable.new(:p),
                Variable.new(:x)
            )
        )
    ),
    Variable.new(:p)
)

while expr_test.reducible?
    puts expr_test
    expr_test = expr_test.reduce
end
puts expr_test
=end

# FunctionをCallでくるんで簡約できるよう修正
=begin
自由変数(inc,zero)を含む式を評価することにはリスクが伴うが,
同じ名前の引数を持つ関数がないため,補足されることはない
=end
inc, zero = Variable.new(:inc), Variable.new(:zero)
expr = Call.new(Call.new(expr, inc), zero)
puts expr
while expr.reducible?
    puts expr
    expr = expr.reduce
end
# puts expr
