require_relative '../../chap2/syntax/while'
require_relative 'type'

class While
    def type(context)
        if self.cond.type(context) == Type::BOOL &&
           self.body.type(context) == Type::VOID
            Type::VOID
        end
    end
end