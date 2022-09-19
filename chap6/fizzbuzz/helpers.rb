require_relative 'only_proc'

# procによる表現をRubyネイティブの値に変換する
def to_integer(proc)
    proc[-> n { n + 1}][0]
end

# puts to_integer(ZERO)
# puts to_integer(THREE)

def to_boolean(proc)
    proc[true][false]
end

# 述語
# puts to_boolean(IS_ZERO[ZERO])
# puts to_boolean(IS_ZERO[THREE])

# ペア
# my_pair = PAIR[THREE][FIVE]
# puts to_integer(LEFT[my_pair])
# puts to_integer(RIGHT[my_pair])

# 数値演算
# 算術演算
# puts to_integer(DECREMENT[FIVE])
# puts to_integer(DECREMENT[FIFTEEN])
# puts to_integer(DECREMENT[ZERO])

# 比較演算子
=begin
puts to_boolean(IS_LESS_OR_EQUAL[ONE][TWO])
puts to_boolean(IS_LESS_OR_EQUAL[TWO][TWO])
puts to_boolean(IS_LESS_OR_EQUAL[THREE][TWO])
=end

# 剰余演算子
=begin
puts to_integer(MOD[THREE][TWO])
puts to_integer(MOD[
    POWER[THREE][THREE]
][
    ADD[THREE][TWO]
])
=end

# 連結リストをRubyネイティブの配列に変換する
def to_array(lst, count = nil)
    array = []
    until to_boolean(IS_EMPTY[lst]) || count == 0
        array.push(FIRST[lst])
        lst = REST[lst]
        count = count - 1 unless count.nil?
    end

    array
end

=begin
my_list =
    UNSHIFT[
        UNSHIFT[
            UNSHIFT[EMPTY][THREE]
        ][TWO]
    ][ONE]
    
    puts to_array(my_list).map { |p| to_integer(p) }.inspect
=end

# 範囲
my_range = RANGE[ONE][FIVE]
# puts to_array(my_range).map { |p| to_integer(p) }.inspect

# FOLD
# puts to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][ADD])
# puts to_integer(FOLD[RANGE[ONE][FIVE]][ONE][MULTIPLY])

# mapメソッド
# my_list = MAP[RANGE[ONE][FIVE]][INCREMENT]
# puts to_array(my_list).map { |p| to_integer(p) }.inspect

# 文字列
def to_char(c)
    # slice()は自身の要素を取り出す
    '0123456789BFiuz'.slice(to_integer(c))
end

def to_string(s)
    to_array(s).map { |c| to_char(c) }.join
end

# puts to_char(ZED)
# puts to_string(FIZZBUZZ)

# 数->文字列
# puts to_array(TO_DIGITS[FIVE]).map { |p| to_integer(p) }.inspect
# puts to_array(TO_DIGITS[POWER[FIVE][THREE]]).map { |p| to_integer(p) }.inspect

# puts to_string(TO_DIGITS[FIVE])
# puts to_string(TO_DIGITS[POWER[FIVE][THREE]])

# FizzBuzz問題の検証
=begin
to_array(SOLUTION).each do |p|
    puts to_string(p)
end; nil
=end

# 無限ストリーム
# puts to_array(ZEROS, 5).map { |p| to_integer(p) }.inspect
# puts to_array(ZEROS, 10).map { |p| to_integer(p) }.inspect
# puts to_array(ZEROS, 20).map { |p| to_integer(p) }.inspect

# 任意の数から数え上げ
# puts to_array(UPWARDS_OF[ZERO], 5).map { |p| to_integer(p) }.inspect
# puts to_array(UPWARDS_OF[FIFTEEN], 20).map { |p| to_integer(p) }.inspect

# 任意の数の倍数
# puts to_array(MULTIPLES_OF[TWO], 10).map { |p| to_integer(p) }.inspect
# puts to_array(MULTIPLES_OF[FIVE], 20).map { |p| to_integer(p) }.inspect

# 既存のストリームにprocをマップ
# puts to_array(MULTIPLES_OF[THREE], 10).map { |p| to_integer(p) }.inspect
# puts to_array(MAP[MULTIPLES_OF[THREE]][INCREMENT], 10).map { |p| to_integer(p) }.inspect
# puts to_array(MAP[MULTIPLES_OF[THREE]][MULTIPLY[TWO]], 10).map { |p| to_integer(p) }.inspect

# ２つのストリームを掛け合わせる
# puts to_array(MULTIPLY_STREAMS[UPWARDS_OF[ONE]][MULTIPLES_OF[THREE]], 10)
#     .map { |p| to_integer(p) }.inspect

# フィボナッチ数列
# puts to_integer(FIBNACCI[TEN])
