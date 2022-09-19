require_relative '../../chap2/syntax/add'
require_relative 'type'

class Add
    def type(context)
        if self.left.type(context) == Type::NUM && 
           self.right.type(context) == Type::NUM
            Type::NUM
        end
        # 型の整合性がとれていない場合はnilを返す
        # 例外を発生させたり,特別なエラー値を返してもよい
    end
end
