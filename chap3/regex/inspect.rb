require_relative 'choose'
require_relative 'concat'
require_relative 'empty'
require_relative 'literal'
require_relative 'pattern'
require_relative 'repeat'

# 正規表現の導入
=begin
pattern = Repeat.new(
    Choose.new(
        Concatenate.new(
            Literal.new('a'),
            Literal.new('b')
        ),
        Literal.new('a')
    )
)
puts pattern
=end

# 空文字と単一文字をNFAへと変換
=begin
nfa_design = Empty.new.to_nfa_design
puts nfa_design.accepts?('')
puts nfa_design.accepts?('a')

nfa_design = Literal.new('a').to_nfa_design
puts nfa_design.accepts?('')
puts nfa_design.accepts?('a')
puts nfa_design.accepts?('b')

puts Empty.new.matches?('a')
puts Literal.new('a').matches?('a')
=end

# 連結をNFAへと変換
=begin
pattern = Concatenate.new(
    Literal.new('a'),
    Concatenate.new(
        Literal.new('b'),
        Literal.new('c')
    )
)

puts pattern.matches?('a')
puts pattern.matches?('ab')
puts pattern.matches?('abc')
=end

# 選択をNFAへと変換
=begin
pattern = Choose.new(
    Literal.new('a'),
    Literal.new('b')
)

puts pattern.matches?('a')
puts pattern.matches?('b')
puts pattern.matches?('c')

# 繰り返しをNFAへと変換
=end

# 繰り返しをNFAへと変換
=begin
pattern = Repeat.new(Literal.new('a'))
puts pattern.matches?('')
puts pattern.matches?('a')
puts pattern.matches?('aaaa')
puts pattern.matches?('b')
=end

# パターンの組み合わせ
pattern = Repeat.new(
    Concatenate.new(
        Literal.new('a'),
        Choose.new(
            Empty.new,
            Literal.new('b')
        )
    )
)

puts pattern
puts pattern.matches?('')
puts pattern.matches?('a')
puts pattern.matches?('ab')
puts pattern.matches?('aba')
puts pattern.matches?('abab')
puts pattern.matches?('abaab')
puts pattern.matches?('abba')
