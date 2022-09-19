require_relative '../../chap2/syntax/if'
require_relative 'type'

class If
    def type(context)
        if self.cond.type(context) == Type::BOOL &&
           self.conseq.type(context) == Type::VOID &&
           self.alter.type(context) == Type::VOID
            Type::VOID
        end
    end
end