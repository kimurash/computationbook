require_relative '../../../chap6/lambda/function'

class Function
    def to_ski
        self.body.to_ski.as_function_of(self.param)
    end
end
