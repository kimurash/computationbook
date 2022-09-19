require_relative 'sign'
require_relative 'numeric'

# 乗算の抽象解釈を定義
# puts (Sign::POSITIVE * Sign::POSITIVE).inspect
# puts (Sign::NEGATIVE * Sign::ZERO).inspect
# puts (Sign::POSITIVE * Sign::NEGATIVE).inspect

# 抽象的な値への変換を実装
# puts (6.sign).inspect
# puts (-9.sign).inspect
# puts (6.sign * -9.sign).inspect

# 実際に演算
def calculate(x, y, z)
  (x * y) * (x * z)
end

=begin
puts calculate(3, -5, 0).inspect
puts calculate(
    Sign::POSITIVE,
    Sign::NEGATIVE,
    Sign::ZERO
).inspect
=end

# 加算の抽象解釈を定義
# puts (Sign::POSITIVE + Sign::POSITIVE).inspect
# puts (Sign::NEGATIVE + Sign::ZERO).inspect
# puts (Sign::NEGATIVE + Sign::POSITIVE).inspect
# puts (Sign::POSITIVE + Sign::UNKNOWN).inspect
# puts (Sign::UNKNOWN + Sign::ZERO).inspect
# puts (Sign::POSITIVE + Sign::NEGATIVE + Sign::NEGATIVE).inspect

# 乗算を任意の数に対応させる
# puts ((Sign::POSITIVE + Sign::NEGATIVE) * Sign::ZERO + Sign::POSITIVE).inspect

# 抽象的な値の安全性を確認するために包含関係を定義
# puts (Sign::POSITIVE <= Sign::POSITIVE)
# puts (Sign::POSITIVE <= Sign::UNKNOWN)
# puts (Sign::POSITIVE <= Sign::NEGATIVE)

# puts (6 * -9).sign <= (6.sign * -9.sign)
# puts (-5 + 0).sign <= (-5.sign + 0.sign)
# puts (6 + -9).sign <= (6.sign + -9.sign)

# おまけ
def sum_of_squares(x, y)
  (x * x) + (y * y)
end

inputs = Sign::NEGATIVE, Sign::ZERO, Sign::POSITIVE
# 抽象的な値ではの潜在的な組み合わせ全てについて
# 調べることも可能である
outputs = inputs.product(inputs).map { |x, y| 
    sum_of_squares(x, y)
}
puts outputs.uniq.inspect
