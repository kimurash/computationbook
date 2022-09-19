require_relative '../../chap2/syntax/mult'
require_relative 'type'

class Mult
    def type(context)
        if self.left.type(context) == Type::NUM &&
           self.right.type(context) == Type::NUM
            Type::NUM
        end
    end
end