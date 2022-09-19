require_relative '../../chap2/syntax/do_nothing'
require_relative 'type'

class DoNothing
    def type(context)
        Type::VOID
    end
end
