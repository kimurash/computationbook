require_relative '../../chap2/syntax/less_than'
require_relative 'type'

class LessThan
    def type(context)
        if self.left.type(context) == Type::NUM &&
           self.right.type(context) == Type::NUM
            Type::BOOL
        end
    end
end