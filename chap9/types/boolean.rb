require_relative '../../chap2/syntax/boolean'
require_relative 'type'

class Boolean
    def type(context)
        Type::BOOL
    end
end
