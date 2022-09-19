require_relative '../../chap2/big_step/add'
require_relative '../../chap2/big_step/boolean'
require_relative '../../chap2/big_step/number'

require_relative 'add'
require_relative 'assign'
require_relative 'boolean'
require_relative 'do_nothing'
require_relative 'if'
require_relative 'less_than'
require_relative 'mult'
require_relative 'number'
require_relative 'sequence'
require_relative 'variable'
require_relative 'while'

# 加算と比較演算子
# puts Add.new(Number.new(1), Number.new(2)).type
# puts Add.new(Number.new(1), Boolean.new(true)).type

# puts LessThan.new(Number.new(1), Number.new(2)).type
# puts LessThan.new(Number.new(1), Boolean.new(true)).type

=begin
ASTの葉に格納される実際の値は無視されるので,
構文的に正しくない式の型を誤って推測してしまう
構文解析は型システムの守備範囲ではない
=end
=begin
bad_expression = Add.new(
    Number.new(true),
    Number.new(1)
)
puts bad_expression.type
bad_expression.evaluate({})
=end
# -> undefined method `+' for true:TrueClass

# 変数
# puts expression = Add.new(Variable.new(:x), Variable.new(:y))
# puts expression.type({})
# 引数に型コンテキストを与えることで
# 変数を含んだ式の型を推測できる
# puts expression.type({ x: Type::NUM, y: Type::NUM })
# puts expression.type({ x: Type::NUM, y: Type::BOOL })

# if文
=begin
puts If.new(
    LessThan.new(
        Number.new(1),
        Number.new(2)
    ),
    DoNothing.new,
    DoNothing.new
).type({})

puts If.new(
    Add.new(
        Number.new(1),
        Number.new(2)
    ),
    DoNothing.new,
    DoNothing.new
).type({})

# while文
puts While.new(
    Variable.new(:x),
    DoNothing.new
).type({ x: Type::BOOL })

puts While.new(
    Variable.new(:x),
    DoNothing.new
).type({ x: Type::NUM })
=end

# 代入文
=begin
statement =
    While.new(
        LessThan.new(
            Variable.new(:x),
            Number.new(5)
        ),
        Assign.new(
            :x, Add.new(
                Variable.new(:x),
                Number.new(3)
            )
        )
    )

puts statement.type({})
puts statement.type({ x: Type::NUM })
puts statement.type({ x: Type::BOOL })
=end

# 無限ループ
=begin
statement =
    Sequence.new(
        Assign.new(:x, Number.new(0)),
        While.new(
            Boolean.new(true),
            Assign.new(:x, Add.new(
                Variable.new(:x),
                Number.new(1)
            ))
        )
    )
=end
# puts statement.type({ x: Type::NUM })
# statement.evaluate({})

# 悲観的な答えを出す
# statement = Sequence.new(statement, Assign.new(:x, Boolean.new(true)))
# puts statement.type({ x: Type::NUM })

# 型と値の依存関係を表現できない
=begin
statement =
    Sequence.new(
        If.new(
            Variable.new(:b),
            Assign.new(:x, Number.new(6)),
            Assign.new(:x, Boolean.new(true))
        ),
        Sequence.new(
            If.new(
                Variable.new(:b),
                Assign.new(:y, Variable.new(:x)),
                Assign.new(:y, Number.new(1))
            ),
            Assign.new(
                :z, 
                Add.new(
                    Variable.new(:y),
                    Number.new(1)
                )
            )
        )
    )
=end
# statement.evaluate({ b: Boolean.new(true) })
# statement.evaluate({ b: Boolean.new(false) })

context = {
    b: Type::BOOL,
    y: Type::NUM,
    z: Type::NUM
}
# puts statement.type(context.merge({ x: Type::NUM }))
# puts statement.type(context.merge({ x: Type::BOOL }))

# 未初期化の変数でもパスする
statement = Assign.new(
    :x,
    Add.new(
        Variable.new(:x),
        Number.new(1)
    )
)
puts statement.type({ x: Type::NUM })
# statement.evaluate({})

