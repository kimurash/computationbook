require_relative '../../chap2/syntax/assign'
require_relative 'type'

class Assign
    def type(context)
        if context[self.name] == self.expression.type(context)
            Type::VOID
        end
    end
end