require_relative '../../../chap6/lambda/variable'
require_relative '../ski_symbol'

class Variable
    def to_ski
        SKISymbol.new(self.name)
    end
end
