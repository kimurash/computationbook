require_relative 'evaluate'

data = %q{
    program = "data = %q{#{data}}" + data
    x = 1
    y = 2
    # puts x + y
    print "#{x + y}\n"
}
program = "data = %q{#{data}}" + data
x = 1
y = 2
# 元のソースにバックスラッシュが含まれていても
# 気にする必要はないのでは?
# puts x + y
print "#{x + y}\n"

# puts program
# eval(program)

# programをn回展開する
interplted = String.new
5.times do |i|
    interplted = "#{program}"
end
puts interplted
