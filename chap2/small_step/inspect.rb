require_relative "add.rb"
require_relative "and.rb"
require_relative "assign.rb"
require_relative "boolean.rb"
require_relative "divide.rb"
require_relative "do_nothing.rb"
require_relative "expr_machine.rb"
require_relative "greater_than.rb"
require_relative "if.rb"
require_relative "less_than.rb"
require_relative "mult.rb"
require_relative "number.rb"
require_relative "sequence.rb"
require_relative "sub.rb"
require_relative "statement_machine.rb"
require_relative "variable.rb"
require_relative "while.rb"

# 以下に実行するASTの構造を記していく

# 変数の導入
=begin
# ExpressionMachine.new(
#     Add.new(Variable.new(:x), Variable.new(:y)),
#     { x: Number.new(3), y: Number.new(4) }
# ).run()
=end

# 代入文の導入
=begin
StatementMachine.new(
    Assign.new(
        :x, Add.new(
            Variable.new(:x), Number.new(3)
        )
    ),
    {x: Number.new(2) }
).run
=end

# if-else文の導入
=begin
StatementMachine.new(
    If.new(
        Variable.new(:x),
        Assign.new(:x, Number.new(1)),
        Assign.new(:x, Number.new(2)),
    ),
    {x: Boolean.new(true) }
).run
=end

# if文を実現
=begin
StatementMachine.new(
    If.new(
        Variable.new(:x),
        Assign.new(
            :y, Number.new(1)
        ),
        DoNothing.new
    ),
    {x: Boolean.new(false)}
).run
=end

# sequence文の導入
=begin
StatementMachine.new(
    Sequence.new(
        Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
        Assign.new(:y, Add.new(Variable.new(:x), Number.new(3))),
    ),
    {}
).run
=end

# while文の導入
=begin
StatementMachine.new(
    While.new(
        LessThan.new(
            Variable.new(:x), Number.new(5)
        ),
        Assign.new(
            :x, Mult.new(
                Variable.new(:x),
                Number.new(3)
            )
        )
    ),
    {x: Number.new(1) }
).run
=end

# 正当性の確認
=begin
構文的には有効だが正しくないプログラムに対処するには
式の簡約可能性をもっと制限する.
具体的には+のオペランドに制限を設ける.
=end
StatementMachine.new(
    Sequence.new(
        Assign.new(
            :x,
            Boolean.new(true)
        ),
        Assign.new(
            :x,
            Add.new(
                Variable.new(:x),
                Number.new(1)
            )
        )
    ),
    {}
).run
