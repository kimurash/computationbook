require_relative '../../chap2/syntax/number'
require_relative 'type'

class Number
    # 評価されたときに返す値の型
    def type(context)
        Type::NUM
    end
end