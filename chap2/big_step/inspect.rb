require_relative "add.rb"
require_relative "assign.rb"
require_relative "boolean.rb"
require_relative "do_nothing.rb"
require_relative "if.rb"
require_relative "less_than.rb"
require_relative "mult.rb"
require_relative "number.rb"
require_relative "sequence.rb"
require_relative "variable.rb"
require_relative "while.rb"

# 式の導入
=begin
puts LessThan.new(
    Add.new(
        Variable.new(:x), Number.new(2),
    ), Variable.new(:y)
).evaluate({x: Number.new(2), y: Number.new(5)})
=end

# sequence文の導入
=begin
puts Sequence.new(
    Assign.new(
        :x, Add.new(
            Number.new(1),
            Number.new(1)
        )
    ),
    Assign.new(
        :y, Add.new(
            Variable.new(:x),
            Number.new(3))
    )
).evaluate({})
=end

# while文の導入
puts While.new(
    LessThan.new(
        Variable.new(:x), Number.new(5)
    ),
    Assign.new(
        :x, Mult.new(
            Variable.new(:x),
            Number.new(3)
        )
    )
).evaluate({ x: Number.new(1) })
