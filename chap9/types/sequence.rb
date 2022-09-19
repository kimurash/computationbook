require_relative '../../chap2/syntax/sequence'
require_relative 'type'

class Sequence
    def type(context)
        if self.first.type(context) == Type::VOID &&
           self.second.type(context) == Type::VOID
            Type::VOID
        end
    end
end
