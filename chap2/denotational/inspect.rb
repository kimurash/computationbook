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

# 数と論理値の導入
=begin
# proc = eval(Number.new(5).to_ruby)
# puts proc.call({})

# proc = eval(Boolean.new(true).to_ruby)
# puts proc.call({})
=end

# 変数の導入
=begin
# expr = Variable.new(:x)
# puts expr.to_ruby
# proc = eval(expr.to_ruby)
# puts proc.call({x: 7})
=end

# 算術演算,論理演算の導入
=begin
env = {x: 3}
proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
puts proc.call(env)

proc = eval(LessThan.new(
    Add.new(
        Variable.new(:x),
        Number.new(1)
    ),
    Number.new(3)
).to_ruby)
puts proc.call(env)
=end

# 代入文の導入
=begin
sttmt = Assign.new(
    :y, Add.new(
        Variable.new(:x), Number.new(1)
    )
)
puts sttmt.to_ruby
proc = eval(sttmt.to_ruby)
puts proc.call({x: 3})
=end

# 文の導入
sttmt = While.new(
    LessThan.new(
        Variable.new(:x), Number.new(5)
    ),
    Assign.new(
        :x, Mult.new(
            Variable.new(:x),
            Number.new(3)
        )
    )
)

puts sttmt.to_ruby
proc = eval(sttmt.to_ruby)
puts proc.call({x: 1})
