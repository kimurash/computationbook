require_relative '../../chap2/syntax/variable'
require_relative 'type'

class Variable
    def type(context)
        context[self.name]
    end
end
